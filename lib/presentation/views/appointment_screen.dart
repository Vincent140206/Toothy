import 'package:flutter/material.dart';
import '../../core/services/schedule_services.dart';
import '../../data/models/doctor.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/models/report.dart';
import '../../data/models/schedule.dart' hide Doctor;


class AppointmentScreen extends StatefulWidget {
  final Doctor doctor;
  final Report? report;
  final String clinicName;
  final String? scheduleId;

  const AppointmentScreen({
    super.key,
    required this.doctor, this.report, required this.clinicName, this.scheduleId,
  });

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? _selectedDate;
  String? _selectedTime;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<List<Schedule>> _loadSchedules() async {
    final service = ScheduleServices();
    if (widget.scheduleId != null) {
      final schedule = await service.getSpecificSchedule(widget.scheduleId!);
      return [schedule];
    } else {
      return await service.getSchedules();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, widget.doctor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  _buildCalendar(),
                  const SizedBox(height: 24),
                  _buildTimeSlots(),
                  SizedBox(height: 20,),
                  _buildBookingButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Doctor doctor) {
    final specialties = doctor.specialists.map((s) => s.title).join(', ');

    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.35, -0.20),
            end: Alignment(1.19, 1.14),
            colors: [const Color(0xFF007FFF), const Color(0xFF004183), const Color(0xFF000307)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x75000000),
              blurRadius: 5,
              offset: Offset(3, 3),
              spreadRadius: 0,
            )
          ],
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Text(
                  'Kembali',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 42,
              backgroundImage: doctor.profilePhotoUrl != null
                  ? NetworkImage(doctor.profilePhotoUrl!)
                  : null,
              child: doctor.profilePhotoUrl == null
                  ? const Icon(Icons.person, size: 50, color: Colors.grey)
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            doctor.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                Text(
                  specialties,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.pin_drop_rounded, color: Colors.white70, size: 24),
                    const SizedBox(width: 6),
                    Text(
                      widget.clinicName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
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

  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDate = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  Widget _buildTimeSlots() {
    return FutureBuilder<List<Schedule>>(
      future: _loadSchedules(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        final schedules = snapshot.data ?? [];

        final filtered = schedules.where((s) =>
        s.doctorId == widget.doctor.id &&
            _selectedDate != null &&
            s.date.year == _selectedDate!.year &&
            s.date.month == _selectedDate!.month &&
            s.date.day == _selectedDate!.day
        ).toList();

        if (filtered.isEmpty) {
          return const Text("Tidak ada jadwal tersedia");
        }

        final availableTimes = filtered.map((s) {
          final start = "${s.startTime.hour.toString().padLeft(2, '0')}:${s.startTime.minute.toString().padLeft(2, '0')}";
          final end = "${s.endTime.hour.toString().padLeft(2, '0')}:${s.endTime.minute.toString().padLeft(2, '0')}";
          return "$start - $end";
        }).toList();

        return Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: availableTimes.map((time) {
            final isSelected = _selectedTime == time;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTime = time;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF007BFF) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF007BFF) : Colors.grey.shade400,
                  ),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF007BFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBookingButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF007BFF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {
          if (_selectedDate != null && _selectedTime != null) {
            final reportInfo = widget.report != null
                ? " (Report ID: ${widget.report!.id})"
                : "";

            final formattedDate =
                "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!
                .year}";

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Janji temu dibuat dengan ${widget.doctor.name} di ${widget
                      .clinicName}, '
                      'tanggal $formattedDate jam $_selectedTime$reportInfo',
                ),
              ),
            );
          }
        },
        child: const Text(
          'Buat Janji Temu',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}