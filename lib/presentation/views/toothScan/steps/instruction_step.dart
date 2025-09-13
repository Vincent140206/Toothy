import 'package:flutter/material.dart';

class InstructionItem extends StatelessWidget {
  final String number;
  final String text;

  const InstructionItem({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF00BFA5).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BFA5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleImageWidget extends StatelessWidget {
  final int id;
  final String label;

  ExampleImageWidget({
    super.key,
    required this.id,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/Example$id.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class InstructionCard extends StatelessWidget {
  const InstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF00BFA5),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Panduan Memindai:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const InstructionItem(
            number: "1",
            text: "Duduk tegak dengan pencahayaan yang cukup agar area mulut terlihat jelas.",
          ),
          const InstructionItem(
            number: "2",
            text: "Buka mulut Anda, lalu turunkan rahang ke bawah secara maksimal.",
          ),
          const InstructionItem(
            number: "3",
            text: "Tarik bibir bawah ke arah bawah menggunakan jari agar gigi terlihat lebih jelas.",
          ),
          const InstructionItem(
            number: "4",
            text: "Arahkan kamera dari atas ke arah dalam mulut dengan jarak 10–15 cm.",
          ),
          const InstructionItem(
            number: "5",
            text: "Pastikan seluruh gigi bawah dan gusi dalam terlihat pada frame di layar.",
          ),
          const InstructionItem(
            number: "6",
            text: "Ambil gambar dan konfirmasi apabila hasil sudah jelas serta sesuai kebutuhan.",
          ),
        ],
      ),
    );
  }
}