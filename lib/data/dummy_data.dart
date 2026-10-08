import '../models/fleet.dart';

const List<Fleet> fleetList = [
  Fleet(
    name: 'Colt Diesel',
    capacity: '4 Ton',
    description: 'Cocok untuk muatan ringan antar kota.',
    imageUrl:
        'https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?w=400',
    basePrice: 1500000,
  ),
  Fleet(
    name: 'Fuso',
    capacity: '8 Ton',
    description: 'Armada menengah untuk muatan industri.',
    imageUrl:
        'https://images.unsplash.com/photo-1586191582056-b7b2b5ed3c1a?w=400',
    basePrice: 2800000,
  ),
  Fleet(
    name: 'Tronton',
    capacity: '20 Ton',
    description: 'Armada besar untuk alat berat dan muatan massal.',
    imageUrl:
        'https://images.unsplash.com/photo-1519003722824-194d4455a60c?w=400',
    basePrice: 5500000,
  ),
];

class HazardGuide {
  final String title;
  final String body;
  const HazardGuide(this.title, this.body);
}

const List<HazardGuide> hazardGuides = [
  HazardGuide(
    'Cairan Mudah Terbakar (Kelas 3)',
    'Gunakan wadah tertutup rapat, jauhkan dari sumber api dan panas, '
        'pasang label "Mudah Terbakar" pada kontainer, dan siapkan APAR di kabin.',
  ),
  HazardGuide(
    'Gas Bertekanan (Kelas 2)',
    'Ikat tabung dalam posisi tegak, lindungi katup dari benturan, '
        'dan jangan muat bersama bahan oksidator.',
  ),
  HazardGuide(
    'Bahan Korosif (Kelas 8)',
    'Gunakan kemasan tahan asam/basa, sediakan APD (sarung tangan, '
        'kacamata, apron), dan pisahkan dari logam serta bahan organik.',
  ),
  HazardGuide(
    'Bahan Beracun (Kelas 6)',
    'Wajib dilengkapi lembar data keselamatan (SDS), sopir harus '
        'bersertifikat B3, dan dilarang dimuat bersama makanan.',
  ),
];

class ReceiptRow {
  final String noResi;
  final String tujuan;
  final String armada;
  final String tonase;
  final String status;
  const ReceiptRow(
      this.noResi, this.tujuan, this.armada, this.tonase, this.status);
}

const List<ReceiptRow> receiptRows = [
  ReceiptRow('CF-001', 'Jakarta', 'Colt Diesel', '3.5 Ton', 'Terkirim'),
  ReceiptRow('CF-002', 'Bandung', 'Fuso', '7 Ton', 'Dalam Perjalanan'),
  ReceiptRow('CF-003', 'Surabaya', 'Tronton', '18 Ton', 'Diproses'),
  ReceiptRow('CF-004', 'Semarang', 'Fuso', '6 Ton', 'Terkirim'),
];