import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:toothy/core/constants/url.dart';
import 'package:toothy/core/services/dio_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class MidTransService {
  final DioClient dioClient = DioClient();
  final Urls urls = Urls();
  MidtransSDK? _midtrans;
  bool _isInitialized = false;

  Future<void> initMidtrans({
    int retryCount = 3,
    bool useSandbox = true,
  }) async {
    if (_isInitialized) return;

    final clientKey = useSandbox
        ? "SB-Mid-client-ohIe6VgGelz6UgEu"
        : "PROD-Mid-client-xxxxx";

    for (int attempt = 1; attempt <= retryCount; attempt++) {
      try {
        await Future.delayed(Duration(milliseconds: 500 * attempt));
        debugPrint("Midtrans initialization attempt $attempt/$retryCount");

        _midtrans = await MidtransSDK.init(
          config: MidtransConfig(
            clientKey: clientKey,
            merchantBaseUrl: "https://toothy-api.bccdev.id/midtrans/",
            enableLog: true,
          ),
        );

        _midtrans?.setTransactionFinishedCallback((result) {
          _handleTransactionResult(result);
        });

        _isInitialized = true;
        return;
      } catch (e) {
        debugPrint("Error initializing Midtrans (attempt $attempt): $e");
        _isInitialized = false;
        if (attempt == retryCount) rethrow;
        await Future.delayed(Duration(milliseconds: 1000));
      }
    }
  }

  void _handleTransactionResult(TransactionResult result) {
    debugPrint("Midtrans Result: $result");
    debugPrint("Midtrans Status: ${result.status}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = navigatorKey.currentContext;
      if (context == null) {
        debugPrint("Navigator context is null, cannot navigate");
        return;
      }

      switch (result.status) {
        case "pending":
          _showResultDialog(
            context,
            "Payment Pending",
            "Your payment is being processed. Please wait for confirmation.",
            Colors.blue.shade200,
                () => _navigateToHome(),
          );
          break;

        case "success":
          _showResultDialog(
            context,
            "Payment Success",
            "Thank you! Your payment has been completed successfully.",
            Colors.green,
                () => _navigateToHome(),
          );
          break;

        case "failed":
          _showResultDialog(
            context,
            "Payment Failed",
            "Payment was unsuccessful. You can try again or contact support.",
            Colors.red,
                () => _navigateBack(),
          );
          break;

        case "cancelled":
          _showResultDialog(
            context,
            "Payment Cancelled",
            "Payment was cancelled by user.",
            Colors.grey,
                () => _navigateBack(),
          );
          break;

        default:
          _navigateToHome();
      }
    });
  }

  void _showResultDialog(
      BuildContext context,
      String title,
      String message,
      Color color,
      VoidCallback onOkPressed
      ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                _getIconForStatus(color),
                color: color,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onOkPressed();
              },
              child: Text(
                "OK",
                style: TextStyle(color: color),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getIconForStatus(Color color) {
    if (color == Colors.green) return Icons.check_circle;
    if (color == Colors.red) return Icons.error;
    if (color == Colors.orange) return Icons.pending;
    return Icons.info;
  }

  void _navigateToHome() {
    try {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/main',
        ModalRoute.withName('/'),
      );
      debugPrint("Successfully navigated to home");
    } catch (e) {
      debugPrint("Error navigating to home: $e");
      _fallbackNavigateToHome();
    }
  }

  void _navigateBack() {
    try {
      if (navigatorKey.currentState?.canPop() == true) {
        navigatorKey.currentState?.pop();
      } else {
        _navigateToHome();
      }
      debugPrint("Successfully navigated back");
    } catch (e) {
      debugPrint("Error navigating back: $e");
      _navigateToHome();
    }
  }

  void _fallbackNavigateToHome() {
    try {
      navigatorKey.currentState?.pushReplacementNamed('/home');
    } catch (e) {
      debugPrint("Fallback navigation also failed: $e");
    }
  }

  Future<void> pay(String snapToken) async {
    print('masuk pay');
    try {
      if (!_isInitialized || _midtrans == null) {
        await initMidtrans();
      }

      print("Starting payment flow with token: $snapToken");
      await _midtrans?.startPaymentUiFlow(token: snapToken);
    } on PlatformException catch (e) {
      debugPrint("Platform Exception: ${e.message}");
      debugPrint("Error Code: ${e.code}");
      debugPrint("Error Details: ${e.details}");

      final context = navigatorKey.currentContext;
      if (context != null) {
        _showResultDialog(
          context,
          "Payment Error",
          "Failed to start payment: ${e.message}",
          Colors.red,
              () => _navigateBack(),
        );
      }

      rethrow;
    } catch (e) {
      debugPrint("General Exception: $e");

      final context = navigatorKey.currentContext;
      if (context != null) {
        _showResultDialog(
          context,
          "Unexpected Error",
          "An unexpected error occurred: $e",
          Colors.red,
              () => _navigateBack(),
        );
      }

      rethrow;
    }
  }

  bool get isInitialized => _isInitialized;

  Future<void> reinitialize() async {
    _isInitialized = false;
    _midtrans = null;
    await initMidtrans();
  }

  void navigateToHomeManually() {
    _navigateToHome();
  }

}