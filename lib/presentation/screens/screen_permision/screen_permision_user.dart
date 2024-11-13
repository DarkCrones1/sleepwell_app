import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';

class ScreenPermisionUser extends StatefulWidget {
  const ScreenPermisionUser({super.key});

  @override
  State<ScreenPermisionUser> createState() => _ScreenPermisionUserState();
}

class _ScreenPermisionUserState extends State<ScreenPermisionUser> {
  final List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.HeartRate,
    HealthConnectDataType.SleepSession,
    HealthConnectDataType.OxygenSaturation,
    HealthConnectDataType.RespiratoryRate,
  ];

  bool readOnly = false;
  String resultText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Connect Permissions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () async {
              var result = await HealthConnectFactory.isApiSupported();
              setState(() {
                resultText = 'isApiSupported: $result';
              });
            },
            child: const Text('isApiSupported'),
          ),
          ElevatedButton(
            onPressed: () async {
              var result = await HealthConnectFactory.isAvailable();
              setState(() {
                resultText = 'isAvailable: $result';
              });
            },
            child: const Text('Check installed'),
          ),
          ElevatedButton(
            onPressed: () async {
              await HealthConnectFactory.installHealthConnect();
            },
            child: const Text('Install Health Connect'),
          ),
          ElevatedButton(
            onPressed: () async {
              await HealthConnectFactory.openHealthConnectSettings();
            },
            child: const Text('Open Health Connect Settings'),
          ),
          ElevatedButton(
            onPressed: () async {
              var result = await HealthConnectFactory.hasPermissions(
                types,
                readOnly: readOnly,
              );
              setState(() {
                resultText = 'hasPermissions: $result';
              });
            },
            child: const Text('Has Permissions'),
          ),
          ElevatedButton(
            onPressed: () async {
              var result = await HealthConnectFactory.requestPermissions(
                types,
                readOnly: readOnly,
              );
              setState(() {
                resultText = 'requestPermissions: $result';
              });
            },
            child: const Text('Request Permissions'),
          ),
          ElevatedButton(
            onPressed: () async {
              var startTime = DateTime.now().subtract(const Duration(days: 4));
              var endTime = DateTime.now();

              // Itera sobre los tipos de datos en `types` y obtiene los registros uno por uno
              for (var type in types) {
                var result = await HealthConnectFactory.getRecord(
                  type: type, // Aquí se pasa un solo tipo a la vez
                  startTime: startTime,
                  endTime: endTime,
                );

                setState(() {
                  resultText += '\nType: ${type.name}\nResult: $result\n';
                });
              }
            },
            child: const Text('Get Record'),
          ),
          Text(resultText),
        ],
      ),
    );
  }
}
