class Service {
  final String title;
  final DateTime date;
  final String price;
  final String nextService;
  final ServiceType type;

  Service({
    required this.title,
    required this.date,
    required this.price,
    required this.nextService,
    required this.type,
  });
}

enum ServiceType { past, upcoming }
