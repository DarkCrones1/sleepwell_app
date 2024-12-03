// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScreenWearable extends StatelessWidget {
  const ScreenWearable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smartwatch'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Información del dispositivo
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.watch,
                  size: 40,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Dispositivo conectado',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                    'Modelo: HUAWEI WATCH FIT YDA-B09S\nEstado: Conectado'),
              ),
            ),
            const Spacer(),
            // Botón para vincular dispositivo
            ElevatedButton.icon(
              onPressed: () {
                // Acción para vincular el dispositivo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Iniciando vinculación con el dispositivo...')),
                );
              },
              icon: const Icon(Icons.devices),
              label: const Text('Vincular dispositivo'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
