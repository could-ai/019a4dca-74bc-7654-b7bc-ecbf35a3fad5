import 'package:flutter/material.dart';

class PingData {
  final String region;
  final int ping;
  final DateTime timestamp;

  PingData({required this.region, required this.ping, required this.timestamp});

  Color get color {
    if (ping < 80) return Colors.green;
    if (ping <= 150) return Colors.yellow;
    return Colors.red;
  }
}

class PingTrend {
  final List<PingData> data;

  PingTrend({required this.data});

  List<PingData> getLast10Minutes() {
    final now = DateTime.now();
    final tenMinutesAgo = now.subtract(const Duration(minutes: 10));
    return data.where((d) => d.timestamp.isAfter(tenMinutesAgo)).toList();
  }
}