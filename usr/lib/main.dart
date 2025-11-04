import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/ping_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PingProvider()),
      ],
      child: MaterialApp(
        title: 'Game Ping Optimizer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(), // Dark mode as requested
        home: const HomeScreen(),
      ),
    );
  }
}