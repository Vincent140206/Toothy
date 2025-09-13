import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toothy/core/utils/token_storage.dart';
import 'package:toothy/data/models/doctor.dart';
import 'package:toothy/presentation/viewmodels/clinic_viewmodel.dart';
import 'package:toothy/presentation/viewmodels/doctor_viewmodel.dart';
import 'package:toothy/presentation/views/home/view/widgets/clinic_list_card.dart';
import '../../../../core/services/article_services.dart';
import '../../../../core/services/clinics_services.dart';
import '../../../../core/services/doctor_services.dart';
import '../../../../core/utils/storage_common.dart';
import '../../../../core/utils/user_storage.dart';
import '../../../../data/models/article.dart';
import '../../../../data/models/clinic.dart';
import '../../../../data/models/user.dart';
import '../../appointment_screen.dart';
import '../../clinic_doctor_list_page.dart';
part 'widgets/home_app_bar.dart';
part 'widgets/appointment_banner.dart';
part 'widgets/top_dentist.dart';
part 'widgets/news_section.dart';
part 'widgets/clinic_list.dart';

class HomeScreen extends StatelessWidget {
  final TokenStorage tokenStorage = TokenStorage();
  final ClinicViewModel clinicViewModel = ClinicViewModel();
  final DoctorViewModel doctorViewModel = DoctorViewModel();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HomeAppBar(),
                const _AppointmentBanner(),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Klinik Kami',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/clinic-list');
                      },
                      child: Text(
                        'Lihat Semua',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const _ClinicList(count: 3,),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text(
                      'Top Dentist',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/dentist-list');
                      },
                      child: Text(
                        'Lihat Semua',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                const _TopDentist(),
                const SizedBox(height: 30),
                Text(
                  'Top Articles',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                const _NewsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}