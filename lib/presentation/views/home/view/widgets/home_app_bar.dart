part of '../home_screen.dart';

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Row(
      children: [
        CircleAvatar(
          radius: screenWidth * 0.06,
          backgroundColor: const Color(0xFF007FFF),
          child: CircleAvatar(
            radius: screenWidth * 0.055,
            backgroundImage:
            const AssetImage('assets/images/ProfilePic.png'),
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo!',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  color: Colors.grey[600],
                  fontSize: screenWidth * 0.035,
                ),
              ),
              Text(
                'Alexandra Pritha',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ],
          ),
        ),
        Image.asset('assets/images/AppBar_HomeScreen.png', width: screenWidth * 0.3)
      ],
    );
  }
}