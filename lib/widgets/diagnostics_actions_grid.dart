import 'package:car_diagnost/screens/service_history_page.dart';
import 'package:flutter/material.dart';
import 'package:car_diagnost/screens/car_status_screen.dart';
import 'package:car_diagnost/screens/monitoring_screen.dart';
import 'package:car_diagnost/screens/manufacturer_details_screen.dart';
import 'package:car_diagnost/screens/fuel_system_screen.dart';
// Сітка з діями-кнопками: діагностика, моніторинг, паливо і т.п.
class DiagnosticsActionsGrid extends StatelessWidget {
  const DiagnosticsActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_GridItem> buttons = [
      _GridItem(Icons.directions_car, 'Діагностика\nавтомобіля', () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CarStatusScreen()));
      }),
      _GridItem(Icons.monitor_heart, 'Моніторинг', () {Navigator.push(context, MaterialPageRoute(builder: (context) => const MonitoringScreen()));
  }),
  
      _GridItem(Icons.info, 'Дані від\nвиробника', () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ManufacturerDetailsScreen()));}),
      _GridItem(Icons.local_gas_station, 'Паливо', () {Navigator.push(context, MaterialPageRoute(builder: (context) => const FuelSystemScreen()));}),
      _GridItem(Icons.library_books, 'Журнал\nобслуговування', () {Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceHistoryPage()));}),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.center,
        children: buttons.map((e) => _buildGridButton(e)).toList(),
      ),
    );
  }

  // Побудова окремої кнопки в сітці
  Widget _buildGridButton(_GridItem item) {
    return Container(
      width: 135,
      height: 135,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: item.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 34, color: Colors.white),
            const SizedBox(height: 9),
            Text(item.label, style: const TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// Клас, що представляє одну кнопку сітки
class _GridItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _GridItem(this.icon, this.label, this.onTap);
}
