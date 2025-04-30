import 'bluetooth_service.dart';

class OBDService {
  final BluetoothService _bluetoothService;

  OBDService(this._bluetoothService);

  Future<Map<String, dynamic>> getOBDData() async {
    if (!_bluetoothService.isConnected) {
      return {"error": "Немає підключення до OBD-II"};
    }

    _bluetoothService.sendCommand('010C'); // Отримати RPM
    String rpmResponse = await _bluetoothService.receiveResponse();

    _bluetoothService.sendCommand('010D'); // Отримати швидкість
    String speedResponse = await _bluetoothService.receiveResponse();
    
    _bluetoothService.sendCommand('0105'); // Отримати температуру двигуна
    String tempResponse = await _bluetoothService.receiveResponse();
    
     _bluetoothService.sendCommand('012F'); // Fuel level (%)
      String fuelResponse = await _bluetoothService.receiveResponse();
   
      double fuelLevel = _parseFuelLevel(fuelResponse);

    return {
      "rpm": _parseOBDResponse(rpmResponse),
      "speed": _parseOBDResponse(speedResponse),
      "engineTemperature": _parseOBDResponse(tempResponse),
      "fuelLevel": fuelLevel
    };
  }
  double _parseFuelLevel(String response) {
  try {
    // приклад для відповіді: "41 2F 64"
    List<String> parts = response.trim().split(' ');
    if (parts.length >= 3) {
      int hex = int.parse(parts[2], radix: 16);
      return (hex * 100) / 255; // згідно OBD-II стандарту
    }
  } catch (_) {}
  return 0.0;
}

  // Метод для обробки відповіді від OBD-II
  int _parseOBDResponse(String response) {
    if (response.isEmpty) return 0;
    return int.tryParse(response.trim().split(' ').last) ?? 0;
  }
}
