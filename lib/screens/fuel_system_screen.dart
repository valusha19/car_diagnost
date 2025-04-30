import 'package:flutter/material.dart';
import '../fuel_system/fuel_header.dart';
import '../fuel_system/current_status_card.dart';
import '../fuel_system/fuel_consumption_card.dart';
import '../fuel_system/additional_info_card.dart';
import '../fuel_system/warnings_card.dart';
import '../services/obd_service.dart';
import '../services/ai_service.dart';
import '../services/bluetooth_service.dart';
import '../services/local_storage_service.dart';

class FuelSystemScreen extends StatefulWidget {
  const FuelSystemScreen({super.key});

  @override
  State<FuelSystemScreen> createState() => _FuelSystemScreenState();
}

class _FuelSystemScreenState extends State<FuelSystemScreen> {
  final OBDService _obdService = OBDService(BluetoothService());
  final AIService _aiService = AIService();

  double fuelLevel = 65;
  double maxFuel = 100;
  double fuelRange = 450;
  double avgConsumption = 32.5;
  double targetConsumption = 28.7;
  String fuelType = "Дизель";
  String fuelQuality = "EN590";
  int nextStationDistance = 25;
  String aiMessage = "Очікуємо дані...";

  @override
  void initState() {
    super.initState();
     _loadSavedData();
    fetchData();
  }
  Future<void> _loadSavedData() async {
    fuelLevel = await LocalStorageService.getData('fuelLevel', 0.0);
    fuelRange = await LocalStorageService.getData('fuelRange', 0.0);
    aiMessage = await LocalStorageService.getData('aiMessage', "Дані недоступні");
    setState(() {});
  }

  Future<void> _saveData() async {
    await LocalStorageService.saveData('fuelLevel', fuelLevel);
    await LocalStorageService.saveData('fuelRange', fuelRange);
    await LocalStorageService.saveData('aiMessage', aiMessage);
  }

  void fetchData() async {
  while (mounted) {
    final Map<String, dynamic> obdData = await _obdService.getOBDData();

    if (!obdData.containsKey('error')) {
      setState(() {
        fuelLevel = (obdData['fuelLevel'] ?? 0).toDouble();
        fuelRange = (fuelLevel / maxFuel) * 700;
      });

    final Map<String, dynamic> aiResponse = await _aiService.getAIResponse(
          "Рівень пального $fuelLevel%, запас ходу $fuelRange км. Чи потрібно щось рекомендувати водію?"
        );
    final String aiResult = aiResponse['text'] ?? "Помилка: відповідь AI відсутня.";
      setState(() {
        aiMessage = aiResult;
      });
    } else {
      setState(() {
        aiMessage = "Дані OBD недоступні";
      });
    }
    await _saveData();
    await Future.delayed(const Duration(seconds: 5));
  }
}
  void updateFuelLevel(double value) {
    setState(() {
      fuelLevel = value;
      fuelRange = (fuelLevel / maxFuel) * 700;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FuelHeader(),
              const SizedBox(height: 20),
              CurrentStatusCard(
                fuelLevel: fuelLevel,
                maxFuel: maxFuel,
                fuelRange: fuelRange,
                onFuelLevelChanged: updateFuelLevel,
              ),
              const SizedBox(height: 12),
              FuelConsumptionCard(
                avgConsumption: avgConsumption,
                targetConsumption: targetConsumption,
              ),
              const SizedBox(height: 12),
              AdditionalInfoCard(
                fuelType: fuelType,
                tankCapacity: maxFuel,
                fuelQuality: fuelQuality,
              ),
              const SizedBox(height: 12),
              WarningsCard(
                nextStationDistance: nextStationDistance,
              ),
              const SizedBox(height: 12),
              Text(
                "AI порада: $aiMessage",
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
