import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:toothy/core/services/dio_client.dart';

import '../../data/models/report.dart';
import '../constants/url.dart';

class ScanServices {
  static DioClient dioClient = DioClient();
  Urls urls = Urls();
  static const List<String> photoTitles = [
    "Pindai Gigi Bagian Dalam Bawah",
    "Pindai Gigi Bagian Dalam Atas",
    "Pindai Gigi Bagian Depan",
  ];

  static const List<String> photoInstructions = [
    "Posisikan Gigi Bagian Bawah\nAnda Terlihat Sepenuhnya",
    "Posisikan Gigi Bagian Atas\nAnda Terlihat Sepenuhnya",
    "Posisikan Gigi Bagian Depan\nAnda Terlihat Sepenuhnya",
  ];

  static Future<CameraController?> setupCamera({
    CameraLensDirection direction = CameraLensDirection.front,
  }) async {
    try {
      final cameras = await availableCameras();
      final selectedCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == direction,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        selectedCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();
      return controller;
    } catch (e) {
      debugPrint('Error setting up camera: $e');
      return null;
    }
  }

  static Future<bool> toggleFlash(
    CameraController controller,
    bool isFlashOn,
  ) async {
    try {
      await controller.setFlashMode(
        isFlashOn ? FlashMode.off : FlashMode.torch,
      );
      return !isFlashOn;
    } catch (e) {
      debugPrint('Error toggling flash: $e');
      return isFlashOn;
    }
  }

  static Future<XFile?> takePicture(CameraController controller) async {
    try {
      return await controller.takePicture();
    } catch (e) {
      debugPrint("Error capture: $e");
      return null;
    }
  }

  static Future<Report?> sendPictures(List<String> images) async {
    try {
      if (images.length < 3) {
        throw Exception("Minimal 3 gambar (depan, atas, bawah) diperlukan");
      }

      FormData formData = FormData();

      formData.files.addAll([
        MapEntry(
          "front_teeth_photo",
          await MultipartFile.fromFile(images[0], filename: images[0].split('/').last),
        ),
        MapEntry(
          "upper_teeth_photo",
          await MultipartFile.fromFile(images[1], filename: images[1].split('/').last),
        ),
        MapEntry(
          "lower_teeth_photo",
          await MultipartFile.fromFile(images[2], filename: images[2].split('/').last),
        ),
      ]);

      formData.fields.add(
        MapEntry("additional_description", "Uploaded from Flutter"),
      );

      print("➡️ Fields: ${formData.fields}");
      print("➡️ Files: ${formData.files.map((f) => f.key).toList()}");

      final response = await dioClient.dio.post(
        Urls.createReports,
        data: formData,
      );

      print("📡 Status: ${response.statusCode}");
      print("📡 Data: ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return Report.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      print("❌ Error sending to API: $e");
      return null;
    }
  }


  static String getCurrentTitle(int currentStep, int currentPhotoIndex) {
    if (currentStep == 1) {
      return "TOOTHSCAN";
    } else {
      return photoTitles[currentPhotoIndex];
    }
  }

  static String getCurrentSubtitle(int currentStep, int currentPhotoIndex) {
    if (currentStep == 1) {
      return "Langkah 1: ${photoTitles[0]}";
    } else {
      return "Langkah ${currentPhotoIndex + 2}: ${photoTitles[currentPhotoIndex]}";
    }
  }

  static Future<List<Report>> getReports() async {
    try {
      final response = await dioClient.dio.get(
        Urls.getReports,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List<dynamic> reportsJson = response.data['data'];
        return reportsJson.map((e) => Report.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error getReports: $e");
      return [];
    }
  }

}
