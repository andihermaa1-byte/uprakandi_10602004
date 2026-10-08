import 'package:flutter/material.dart';

class DepotInfoPage extends StatelessWidget {
  const DepotInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warehouse, size: 40, color: Colors.indigo),
              SizedBox(width: 12),
              Expanded(
                child: SelectableText(
                  'Depo Utama CargoFlow Subang',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SelectableText(
            'Alamat: Jl. Raya Pantura KM 12, Subang, Jawa Barat 41211\n'
            'Jam Operasional: Senin - Sabtu, 07.00 - 21.00 WIB\n'
            'Telepon: (0260) 555-0123',
          ),
          SizedBox(height: 24),
          Text(
            'Kode Tracking API Pusat',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SelectableText(
            'CFAPI-SUB-2026-9X4K-77QZ',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 18,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tekan dan tahan teks di atas untuk menyalin.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}