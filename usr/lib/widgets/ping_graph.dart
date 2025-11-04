import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/ping_data.dart';

class PingGraph extends StatelessWidget {
  final List<PingData> data;

  const PingGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = data.map((d) => FlSpot(d.timestamp.millisecondsSinceEpoch.toDouble(), d.ping.toDouble())).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}