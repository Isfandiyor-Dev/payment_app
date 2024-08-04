import 'package:flutter/material.dart';
import 'package:payment_app/ui/auth/auth_gate/auth_gate.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[200],
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue[300]),
      ),
      home: Scaffold(
        body: const AuthGate(),
      ),
    );
  }
}
