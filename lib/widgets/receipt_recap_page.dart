import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class ReceiptRecapPage extends StatelessWidget {
  const ReceiptRecapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStatePropertyAll(Colors.indigo.shade50),
          columns: const [
            DataColumn(label: Text('No. Resi')),
            DataColumn(label: Text('Tujuan')),
            DataColumn(label: Text('Armada')),
            DataColumn(label: Text('Tonase')),
            DataColumn(label: Text('Status')),
          ],
          rows: receiptRows
              .map(
                (r) => DataRow(cells: [
                  DataCell(Text(r.noResi)),
                  DataCell(Text(r.tujuan)),
                  DataCell(Text(r.armada)),
                  DataCell(Text(r.tonase)),
                  DataCell(Text(r.status)),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}