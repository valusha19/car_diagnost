import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert';

class BluetoothService {
  BluetoothConnection? _connection;
  bool isConnected = false;

  Future<void> connect(String address) async {
    try {
      _connection = await BluetoothConnection.toAddress(address);
      isConnected = true;
      print('✅ Підключено до OBD-II');
    } catch (e) {
      print('❌ Помилка підключення: $e');
      isConnected = false;
    }
  }

  void sendCommand(String command) {
    if (_connection != null && isConnected) {
      _connection!.output.add(utf8.encode('$command\r'));
      _connection!.output.allSent;
    }
  }

  Future<String> receiveResponse() async {
    if (_connection == null || !isConnected) return "❌ Немає підключення";

    List<int> buffer = [];
    _connection!.input!.listen((List<int> data) {
      buffer.addAll(data);
    });

    await Future.delayed(const Duration(seconds: 1));
    return utf8.decode(buffer);
  }

  void disconnect() {
    _connection?.close();
    isConnected = false;
  }
}
