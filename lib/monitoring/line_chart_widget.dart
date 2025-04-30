import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // БЕЗ цього графік НЕ видно
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: LineChart(_chartData()),
      ),
    );
  }

  /// Основні налаштування графіка
  LineChartData _chartData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false), // Без взаємодії з графіком
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) => FlLine(
          color: const Color.fromARGB(255, 163, 110, 110),
          strokeWidth: 0.5,
        ),
      ),
      titlesData: FlTitlesData(show: false), // Без міток на осях
      borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(color: Colors.black, width: 1),
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      lineBarsData: [
        _buildLine(
          [
            FlSpot(0, 3),
            FlSpot(1, 2.8),
            FlSpot(2, 3.5),
            FlSpot(3, 2),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 4.2),
          ],
          Colors.teal,
        ),
        _buildLine(
          [
            FlSpot(0, 2.3),
            FlSpot(1, 2.5),
            FlSpot(2, 2.8),
            FlSpot(3, 3.6),
            FlSpot(4, 3.2),
            FlSpot(5, 3.5),
            FlSpot(6, 4.1),
          ],
          Colors.orange,
        ),
        _buildLine(
          [
            FlSpot(0, 1.5),
            FlSpot(1, 2),
            FlSpot(2, 2.2),
            FlSpot(3, 2.8),
            FlSpot(4, 3),
            FlSpot(5, 3.8),
            FlSpot(6, 4.5),
          ],
          Colors.black87,
        ),
      ],
    );
  }

  /// Метод для створення лінії на графіку
  LineChartBarData _buildLine(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
}
