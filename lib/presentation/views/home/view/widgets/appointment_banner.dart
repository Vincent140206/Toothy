part of '../home_screen.dart';

class _AppointmentBanner extends StatelessWidget {
  const _AppointmentBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF007FFF),
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Icon_noAppointment.png',
            width: screenWidth * 0.07,
          ),
          SizedBox(width: screenWidth * 0.04),
          Text(
            'Belum ada Appointment!',
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

