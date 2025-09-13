import 'package:flutter/material.dart';
import 'package:toothy/presentation/views/clinic_doctor_list_page.dart';

class ClinicListCard extends StatelessWidget {
  final String id;
  final String name;
  final String photo_url;
  final String address;
  final String open_time;
  final String close_time;

  const ClinicListCard({
    required this.id,
    required this.name,
    required this.photo_url,
    required this.address,
    required this.open_time,
    required this.close_time, required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ClinicDoctorListPage(clinicId: id,)));
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffE9FAFF),
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                photo_url,
                width: screenWidth * 0.22,
                height: screenWidth * 0.22,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: screenWidth * 0.22,
                    height: screenWidth * 0.22,
                    color: Colors.grey[200],
                    child: const Icon(
                        Icons.person, size: 40, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded,
                          color: Colors.grey.shade400, size: 30),
                    ],
                  ),
                  Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                      color: Colors.grey[600],
                      fontSize: screenWidth * 0.032,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                      children: [
                        Icon(Icons.access_time, size: screenWidth * 0.04, color: Colors.grey[600]),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          '$open_time - $close_time',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            color: Colors.grey[600],
                            fontSize: screenWidth * 0.032,
                          ),
                        ),
                      ]
                  )
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
          ],
        ),
      ),
    );
  }
}