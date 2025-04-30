class DiagnosticResult {
  final String component;
  final String status;
  final String recommendation;

  DiagnosticResult({
    required this.component,
    required this.status,
    required this.recommendation,
  });

  // Створення об'єкта з JSON
  factory DiagnosticResult.fromJson(Map<String, dynamic> json) {
    return DiagnosticResult(
      component: json['component'] ?? 'Невідомо',
      status: json['status'] ?? 'Невідомий',
      recommendation: json['recommendation'] ?? 'Немає рекомендацій',
    );
  }

  // Перетворення об'єкта в JSON
  Map<String, dynamic> toJson() {
    return {
      'component': component,
      'status': status,
      'recommendation': recommendation,
    };
  }
}
