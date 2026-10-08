import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/fleet.dart';

class FleetTab extends StatelessWidget {
  final void Function(Fleet fleet) onSelect;
  const FleetTab({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: fleetList.length,
      itemBuilder: (context, index) {
        final fleet = fleetList[index];
        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        fleet.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.local_shipping, size: 36),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        fleet.capacity,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              fleet.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(fleet.description),
            trailing: ElevatedButton(
              onPressed: () => onSelect(fleet),
              child: const Text('Pilih Armada'),
            ),
          ),
        );
      },
    );
  }
}