import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/ping_data.dart';

class PingService {
  static const Map<String, String> servers = {
    'Singapore': 'https://sg-servers.example.com', // Placeholder URLs
    'Frankfurt': 'https://de-servers.example.com',
    'Virginia': 'https://us-servers.example.com',
  };

  Future<int> pingServer(String region) async {
    final url = servers[region] ?? 'https://google.com'; // Fallback
    final start = DateTime.now().millisecondsSinceEpoch;
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      final end = DateTime.now().millisecondsSinceEpoch;
      return end - start;
    } catch (e) {
      return -1; // Error
    }
  }

  Stream<PingData> monitorPing(String region) async* {
    while (true) {
      final ping = await pingServer(region);
      yield PingData(region: region, ping: ping, timestamp: DateTime.now());
      await Future.delayed(const Duration(seconds: 1)); // Ping every second
    }
  }
}