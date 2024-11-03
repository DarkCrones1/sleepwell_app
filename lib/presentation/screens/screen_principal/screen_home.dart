
import 'package:flutter/material.dart';

class ScreenHomePage extends StatelessWidget {
  const ScreenHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inicio',
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