class VehicleConnection {
  final String model;
  final DateTime lastConnected;
  final bool isConnected;

  VehicleConnection({
    required this.model,
    required this.lastConnected,
    required this.isConnected,
  });
}