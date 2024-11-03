
import 'package:flutter/material.dart';

class ScreenTimePage extends StatelessWidget {
  const ScreenTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Horario',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.bold, // Texto blanco
          ),
        ),
        actions: const [],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '',
                  style: TextStyle(
                    fontFamily: 'ROBOTO',
                    fontSize: 30,
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}