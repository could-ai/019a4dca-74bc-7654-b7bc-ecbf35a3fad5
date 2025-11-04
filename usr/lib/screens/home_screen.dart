import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ping_provider.dart';
import '../widgets/ping_card.dart';
import '../widgets/ping_graph.dart';
import '../models/ping_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Start monitoring pings
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PingProvider>(context, listen: false);
      provider.startMonitoring();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Ping Optimizer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showOptimizationDialog(context),
          ),
        ],
      ),
      body: Consumer<PingProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Ping Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: provider.pingData.entries.map((entry) {
                    return Expanded(
                      child: PingCard(data: entry.value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                // Graph
                Expanded(
                  child: PingGraph(data: provider.trendData.getLast10Minutes()),
                ),
                const SizedBox(height: 20),
                // Optimization Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _optimizeGamingMode(),
                      child: const Text('Gaming Mode'),
                    ),
                    ElevatedButton(
                      onPressed: () => _switchDNS(),
                      child: const Text('Fast DNS'),
                    ),
                    ElevatedButton(
                      onPressed: () => _suggestNetwork(provider),
                      child: const Text('Best Network'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showOptimizationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Optimizations'),
        content: const Text('One-tap optimization features.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _optimizeGamingMode() {
    // Placeholder: Disable background apps (not fully implemented)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gaming mode enabled (simulated)')),
    );
  }

  void _switchDNS() {
    // Placeholder: Switch to fastest DNS
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Switched to fastest DNS (simulated)')),
    );
  }

  void _suggestNetwork(PingProvider provider) {
    // Placeholder: Suggest based on signal quality
    final suggestion = provider.networkType == 'Wi-Fi' ? 'Stay on Wi-Fi' : 'Switch to Wi-Fi';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(suggestion)),
    );
  }
}