import 'package:flutter/material.dart';
import 'package:car_diagnost/widgets/car_status_appbar.dart';
import 'package:car_diagnost/widgets/car_status_card.dart';

class CarStatusScreen extends StatelessWidget {
  const CarStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CarStatusAppBar(), // верхній заголовок із іконками
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CarStatusCard(), // картка з даними перевірки
      ),
    );
  }
}
