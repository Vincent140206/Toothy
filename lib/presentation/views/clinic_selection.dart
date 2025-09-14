import 'package:flutter/material.dart';
import 'package:toothy/presentation/views/clinic_doctor_list_page.dart';
import '../../../data/models/clinic.dart';
import '../../../data/models/report.dart';
import '../../core/utils/storage_common.dart';

class ClinicSelectionPage extends StatefulWidget {
  final Report? report;

  const ClinicSelectionPage({super.key, this.report});

  @override
  State<ClinicSelectionPage> createState() => _ClinicSelectionPageState();
}

class _ClinicSelectionPageState extends State<ClinicSelectionPage> {
  List<Clinic> clinics = [];
  bool isLoading = true;
  String? errorMessage;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadClinics();
  }

  void _loadClinics() async {
    setState(() => isLoading = true);

    try {
      final result = await StorageCommon.getClinics();
      setState(() {
        clinics = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Gagal memuat klinik: $e";
        isLoading = false;
      });
    }
  }

  List<Clinic> get filteredClinics {
    if (searchQuery.isEmpty) return clinics;
    return clinics.where((clinic) =>
    clinic.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        clinic.address.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Pilih Klinik",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0077FF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: const InputDecoration(
                hintText: 'Cari klinik atau lokasi...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF6B7280)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? _buildLoadingState()
                : errorMessage != null
                ? _buildErrorState()
                : filteredClinics.isEmpty
                ? _buildEmptyState()
                : _buildClinicList(),
          ),
        ],
      ),
    );
  }
  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D8F)),
          ),
          SizedBox(height: 16),
          Text(
            'Memuat daftar klinik...',
            style: TextStyle(color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFEF4444),
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? 'Terjadi kesalahan',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Color(0xFF6B7280),
            ),
            SizedBox(height: 16),
            Text(
              'Tidak ada klinik ditemukan',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClinicList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredClinics.length,
      itemBuilder: (context, index) {
        final clinic = filteredClinics[index];
        return _buildClinicCard(clinic);
      },
    );
  }

  Widget _buildClinicCard(Clinic clinic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToBooking(clinic),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    clinic.photoUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 80,
                      height: 80,
                      color: const Color(0xFFF3F4F6),
                      child: const Icon(
                        Icons.local_hospital,
                        color: Color(0xFF6B7280),
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clinic.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Color(0xFF6B7280),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              clinic.address,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6B7280),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Color(0xFF059669),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${clinic.openTime} - ${clinic.closeTime}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF059669),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D8F).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFF2E7D8F),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToBooking(Clinic clinic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClinicDoctorListPage(
          report: widget.report, clinicId: clinic.id ?? '',
        ),
      ),
    );
  }
}