part of '../home_screen.dart';

class _AppointmentBanner extends StatefulWidget {
  const _AppointmentBanner({super.key});

  @override
  State<_AppointmentBanner> createState() => _AppointmentBannerState();
}

class _AppointmentBannerState extends State<_AppointmentBanner> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AppointmentViewModel>().fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final appointmentVM = context.watch<AppointmentViewModel>();
    final appointments = appointmentVM.appointments;

    String clinicName = '';
    String doctorName = '';
    String appointmentDate = '';
    String timeInfo = '';
    String icon = 'assets/images/Icon_noAppointment.png';
    Color bannerColor = const Color(0xFF6B7280);

    final validAppointments = appointments
        .where((a) =>
    a.status.toUpperCase() != "CANCELLED" &&
        a.date != null &&
        a.date!.isAfter(DateTime.now()))
        .toList();

    if (validAppointments.isNotEmpty) {
      validAppointments.sort((a, b) => a.date!.compareTo(b.date!));
      final nearest = validAppointments.first;

      final duration = nearest.date!.difference(DateTime.now());
      if (duration.inDays > 0) {
        timeInfo = '${duration.inDays} hari lagi';
      } else if (duration.inHours > 0) {
        timeInfo = '${duration.inHours} jam lagi';
      } else if (duration.inMinutes > 0) {
        timeInfo = '${duration.inMinutes} menit lagi';
      } else {
        timeInfo = 'Sebentar lagi';
      }

      DateTime parsedDate;
      final tanggal = nearest.date;
      if (tanggal is String) {
        parsedDate = DateTime.parse(tanggal as String);
      } else if (tanggal is DateTime) {
        parsedDate = tanggal;
      } else {
        parsedDate = DateTime.now();
      }

      appointmentDate = DateFormat('dd MMMM yyyy HH:mm').format(parsedDate);
      clinicName = nearest.schedule?.clinicName ?? '';
      doctorName = nearest.doctorName ?? '';

      icon = 'assets/images/Icon_Appointment.png';
      bannerColor = const Color(0xFF007FFF);
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        gradient: validAppointments.isNotEmpty
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bannerColor,
            bannerColor.withOpacity(0.8),
          ],
        )
            : LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bannerColor,
            bannerColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: bannerColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: Image.asset(
                icon,
                width: screenWidth * 0.07,
                height: screenWidth * 0.07,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (clinicName.isNotEmpty)
                      Text(
                        clinicName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.042,
                          color: Colors.white,
                        ),
                      ),
                    SizedBox(height: 5,),
                    if (doctorName.isNotEmpty)
                      Text(
                        doctorName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.036,
                          color: Colors.white,
                        ),
                      ),
                    if (appointmentDate.isNotEmpty)
                      Text(
                        '$appointmentDate ($timeInfo)',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * 0.034,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    if (clinicName.isEmpty)
                      Text(
                        'Belum ada Appointment!',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.038,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}