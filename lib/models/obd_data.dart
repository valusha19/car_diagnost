class OBDData {
  final int rpm;
  final int speed;
  final double engineTemperature;
  final double fuelLevel;

  OBDData({
    required this.rpm,
    required this.speed,
    required this.engineTemperature,
    required this.fuelLevel,
  });

  // Створення об'єкта з JSON
  factory OBDData.fromJson(Map<String, dynamic> json) {
    return OBDData(
      rpm: json['rpm'] ?? 0,
      speed: json['speed'] ?? 0,
      engineTemperature: (json['engineTemperature'] ?? 0).toDouble(),
      fuelLevel: (json['fuelLevel'] ?? 0).toDouble(),
    );
  }

  // Перетворення об'єкта в JSON
  Map<String, dynamic> toJson() {
    return {
      'rpm': rpm,
      'speed': speed,
      'engineTemperature': engineTemperature,
      'fuelLevel': fuelLevel,
    };
  }
}
