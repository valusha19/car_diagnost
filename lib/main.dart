import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/car_diagnostics_screen.dart';
import 'services/firebase_service.dart';
import 'services/firebase_notifications.dart';
// Імпортуйте інші екрани тут за потреби

final Map<String, WidgetBuilder> appRoutes = {
  '/diagnostics': (context) => const CarDiagnosticsScreen(),
  // Додайте інші маршрути за потреби
};


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
// Ініціалізація Firebase та сповіщень
  await FirebaseService.init();
  await FirebaseNotifications.init();

  runApp(const CarDiagnosticsApp());
}
class CarDiagnosticsScreen extends StatelessWidget {
const CarDiagnosticsScreen({super.key}); // Додаємо super.key
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Діагностика автомобіля")),
      body: Center(child: Text("Головний екран")),
    );
  }
}

// class MyApp extends StatelessWidget {
  //const MyApp({super.key});

 // @override
  //Widget build(BuildContext context) {
 // return MaterialApp(
   //debugShowCheckedModeBanner: false,
    // home: const CarDiagnosticsScreen(),
   // );
 // }
 //}

class CarDiagnosticsApp extends StatelessWidget {
  const CarDiagnosticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Діагностика автомобіля',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      // initialRoute: '/',
      home: CarDiagnosticsUIScreen(),
      routes: appRoutes,  // Використання визначених маршрутів
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF404850),
      scaffoldBackgroundColor: const Color(0xFF404850),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF404850),
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
      ),
    );
  }
  
}


