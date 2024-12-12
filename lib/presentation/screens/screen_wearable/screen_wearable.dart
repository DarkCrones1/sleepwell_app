// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScreenWearable extends StatefulWidget {
  const ScreenWearable({super.key});

  @override
  State<ScreenWearable> createState() => _ScreenWearableState();
}

class _ScreenWearableState extends State<ScreenWearable> {
  // Variables para el estado del dispositivo
  String deviceModel = 'Desconocido';
  String connectionStatus = 'Desconectado';
  bool isLoading = false;

  // Simulación de obtención de datos del dispositivo
  Future<void> fetchDeviceInfo() async {
    setState(() {
      isLoading = true;
    });

    // Simula un retraso para la obtención de datos
    await Future.delayed(Duration(seconds: 2));

    // Simula datos del dispositivo conectado (puedes reemplazar esto con una API real)
    setState(() {
      deviceModel = 'AMAZFIT BAND 7';
      connectionStatus = 'Conectado';
      isLoading = false;
    });
  }

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
                title: Text(
                  'Dispositivo conectado',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Modelo: $deviceModel\nEstado: $connectionStatus',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const Spacer(),
            // Indicador de carga
            if (isLoading)
              CircularProgressIndicator()
            else
              // Botón para obtener información del dispositivo
              ElevatedButton.icon(
                onPressed: fetchDeviceInfo,
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
