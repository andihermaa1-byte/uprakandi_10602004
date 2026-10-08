import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class HazardTab extends StatefulWidget {
  const HazardTab({super.key});

  @override
  State<HazardTab> createState() => _HazardTabState();
}

class _HazardTabState extends State<HazardTab> {
  late final List<bool> _expanded =
      List<bool>.filled(hazardGuides.length, false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: ExpansionPanelList(
        expansionCallback: (index, isExpanded) {
          setState(() => _expanded[index] = isExpanded);
        },
        children: List.generate(hazardGuides.length, (i) {
          final guide = hazardGuides[i];
          return ExpansionPanel(
            isExpanded: _expanded[i],
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) => ListTile(
              leading: const Icon(Icons.warning_amber, color: Colors.red),
              title: Text(guide.title),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(guide.body),
              ),
            ),
          );
        }),
      ),
    );
  }
}