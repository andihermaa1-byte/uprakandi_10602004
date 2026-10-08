import 'package:flutter/material.dart';

import '../models/fleet.dart';
import '../widgets/depot_info_page.dart';
import '../widgets/fleet_tab.dart';
import '../widgets/hazard_tab.dart';
import '../widgets/receipt_recap_page.dart';
import 'cargo_booking_screen.dart';
import 'login_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  static const _titles = ['Manifes Muatan', 'Rekap Resi', 'Informasi Depo'];

  Future<void> _openBooking(Fleet fleet) async {
    // Passing data: kirim armada terpilih, lalu tunggu returning data.
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => CargoBookingScreen(fleet: fleet)),
    );

    if (!mounted) return;
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _selectFromDrawer(int index) {
    Navigator.pop(context); // tutup drawer
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.local_shipping), text: 'Armada Tersedia'),
                Tab(icon: Icon(Icons.warning), text: 'Syarat Muatan Berbahaya'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FleetTab(onSelect: _openBooking),
                  const HazardTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      const ReceiptRecapPage(),
      const DepotInfoPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.local_shipping, size: 28),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Armada B 9021 CF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Staf: petugas',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text('Manifes Muatan'),
              onTap: () => _selectFromDrawer(0),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Rekap Resi'),
              onTap: () => _selectFromDrawer(1),
            ),
            ListTile(
              leading: const Icon(Icons.warehouse),
              title: const Text('Informasi Depo'),
              onTap: () => _selectFromDrawer(2),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Keluar'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Manifes Muatan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Rekap Resi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warehouse),
            label: 'Informasi Depo',
          ),
        ],
      ),
    );
  }
}