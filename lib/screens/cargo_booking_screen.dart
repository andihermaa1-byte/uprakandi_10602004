import 'package:flutter/material.dart';

import '../models/fleet.dart';

class CargoBookingScreen extends StatefulWidget {
  final Fleet fleet;
  const CargoBookingScreen({super.key, required this.fleet});

  @override
  State<CargoBookingScreen> createState() => _CargoBookingScreenState();
}

class _CargoBookingScreenState extends State<CargoBookingScreen> {
  // Kategori muatan (Radio)
  static const _categories = {
    'General Cargo': 0,
    'Makanan Beku/Perishable': 500000,
    'Alat Berat': 1000000,
  };
  String _category = 'General Cargo';

  // Proteksi pengiriman (Checkbox)
  static const _protections = {
    'Asuransi Barang Rusak': 250000,
    'Jasa Forklift Muat': 300000,
    'Pengawalan Prioritas': 450000,
  };
  final Map<String, bool> _selectedProtections = {
    for (final k in _protections.keys) k: false,
  };

  // Jadwal
  DateTime? _pickupDate;
  TimeOfDay? _departureTime;

  // Pengaturan muatan
  double _tonnage = 1;
  bool _reefer = false;

  late final double _maxTonnage = _fleetMaxTonnage();

  double _fleetMaxTonnage() {
    final digits = RegExp(r'\d+').firstMatch(widget.fleet.capacity)?.group(0);
    return double.tryParse(digits ?? '') ?? 20;
  }

  int get _totalCost {
    var total = widget.fleet.basePrice;
    total += _categories[_category]!;
    total += (_tonnage * 100000).round();
    _selectedProtections.forEach((name, checked) {
      if (checked) total += _protections[name]!;
    });
    if (_reefer) total += 750000;
    return total;
  }

  String _rupiah(int value) {
    final s = value.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp $buf';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _pickupDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _pickupDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _departureTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _departureTime = picked);
  }

  void _showCostSheet() {
    if (_pickupDate == null || _departureTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal penjemputan dan jam keberangkatan dulu.'),
        ),
      );
      return;
    }

    final chosen = _selectedProtections.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rincian Biaya Surat Jalan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Text('Armada: ${widget.fleet.name} (${widget.fleet.capacity})'),
                Text('Kategori: $_category'),
                Text('Tonase: ${_tonnage.toStringAsFixed(1)} Ton'),
                Text(
                  'Proteksi: ${chosen.isEmpty ? '-' : chosen.join(', ')}',
                ),
                Text('Reefer Container: ${_reefer ? 'Aktif' : 'Tidak'}'),
                Text(
                  'Penjemputan: ${_pickupDate!.day}/${_pickupDate!.month}/'
                  '${_pickupDate!.year} • ${_departureTime!.format(context)}',
                ),
                const Divider(),
                Text(
                  'Total: ${_rupiah(_totalCost)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final ok = await showDialog<bool>(
                        context: sheetContext,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Terbitkan Surat Jalan?'),
                          content: Text(
                            'Surat jalan untuk ${widget.fleet.name} dengan '
                            'total ${_rupiah(_totalCost)} akan diterbitkan.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, false),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, true),
                              child: const Text('Setuju'),
                            ),
                          ],
                        ),
                      );

                      if (ok == true && sheetContext.mounted) {
                        Navigator.pop(sheetContext); // tutup bottom sheet
                        if (mounted) {
                          // returning data ke layar utama
                          Navigator.pop(
                            context,
                            'Resi berhasil diterbitkan untuk armada '
                            '${widget.fleet.name} (${_rupiah(_totalCost)})',
                          );
                        }
                      }
                    },
                    child: const Text('Konfirmasi & Terbitkan Surat Jalan'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking: ${widget.fleet.name}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.local_shipping, color: Colors.indigo),
              title: Text(widget.fleet.name),
              subtitle: Text('Kapasitas ${widget.fleet.capacity}'),
            ),
          ),
          const SizedBox(height: 12),

          const Text('Kategori Muatan',
              style: TextStyle(fontWeight: FontWeight.bold)),
                    RadioGroup<String>(
            groupValue: _category,
            onChanged: (v) => setState(() => _category = v!),
            child: Column(
              children: _categories.keys
                  .map((c) => RadioListTile<String>(title: Text(c), value: c))
                  .toList(),
            ),
          ),
          const Divider(),

          const Text('Proteksi Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ..._selectedProtections.keys.map(
            (p) => CheckboxListTile(
              title: Text(p),
              value: _selectedProtections[p],
              onChanged: (v) =>
                  setState(() => _selectedProtections[p] = v ?? false),
            ),
          ),
          const Divider(),

          const Text('Jadwal Pengambilan',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _pickupDate == null
                        ? 'Pilih Tanggal'
                        : '${_pickupDate!.day}/${_pickupDate!.month}/${_pickupDate!.year}',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.access_time),
                  label: Text(
                    _departureTime == null
                        ? 'Pilih Jam'
                        : _departureTime!.format(context),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 32),

          const Text('Pengaturan Muatan',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Estimasi Tonase: ${_tonnage.toStringAsFixed(1)} Ton'),
          Slider(
            value: _tonnage.clamp(1, _maxTonnage),
            min: 1,
            max: _maxTonnage,
            divisions: ((_maxTonnage - 1) * 2).round(),
            label: '${_tonnage.toStringAsFixed(1)} Ton',
            onChanged: (v) => setState(() => _tonnage = v),
          ),
          SwitchListTile(
            title: const Text('Aktifkan Reefer Container'),
            subtitle: const Text('Mesin pendingin kontainer (+Rp 750.000)'),
            value: _reefer,
            onChanged: (v) => setState(() => _reefer = v),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _showCostSheet,
              icon: const Icon(Icons.calculate),
              label: const Text('Hitung Biaya Logistik'),
            ),
          ),
        ],
      ),
    );
  }
}