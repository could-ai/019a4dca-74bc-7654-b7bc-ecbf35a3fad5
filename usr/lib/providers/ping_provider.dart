import 'package:flutter/material.dart';
import '../models/ping_data.dart';
import '../services/ping_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class PingProvider extends ChangeNotifier {
  final Map<String, PingData> _pingData = {};
  final PingTrend _trendData = PingTrend(data: []);
  String _networkType = 'Unknown';
  StreamSubscription? _subscription;

  Map<String, PingData> get pingData => _pingData;
  PingTrend get trendData => _trendData;
  String get networkType => _networkType;

  void startMonitoring() {
    // Monitor each region
    for (final region in PingService.servers.keys) {
      PingService().monitorPing(region).listen((data) {
        _pingData[region] = data;
        _trendData.data.add(data);
        // Keep only last 10 minutes
        _trendData.data.removeWhere((d) => DateTime.now().difference(d.timestamp).inMinutes > 10);
        notifyListeners();
      });
    }
    // Monitor connectivity
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      _networkType = result.toString();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}