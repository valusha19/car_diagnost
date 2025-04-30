import 'package:flutter/material.dart';
import 'package:car_diagnost/screens/car_diagnostics_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const CarDiagnosticsUIScreen(),
  '/diagnostics': (context) => const CarDiagnosticsUIScreen(),
};
