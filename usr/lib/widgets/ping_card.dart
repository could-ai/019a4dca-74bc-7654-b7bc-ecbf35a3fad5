import 'package:flutter/material.dart';
import '../models/ping_data.dart';

class PingCard extends StatelessWidget {
  final PingData data;

  const PingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(data.region, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              data.ping == -1 ? 'Error' : '${data.ping} ms',
              style: TextStyle(
                fontSize: 24,
                color: data.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}