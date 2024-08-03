import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("History Screen", style: TextStyle(fontSize: 20)),
        )
      ],
    );
  }
}
