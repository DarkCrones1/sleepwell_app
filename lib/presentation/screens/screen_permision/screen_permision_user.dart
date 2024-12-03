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
        title: const Text('Permisos de Health Connect'),
        backgroundColor: const Color(0xFF40D9FF),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40D9FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    var result = await HealthConnectFactory.isApiSupported();
                    setState(() {
                      resultText = '¿API soportada?: $result';
                    });
                  },
                  child: const Text(
                    '¿Es API soportada?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40D9FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    var result = await HealthConnectFactory.isAvailable();
                    setState(() {
                      resultText = '¿Está instalada?: $result';
                    });
                  },
                  child: const Text(
                    'Comprobar instalación',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40D9FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await HealthConnectFactory.installHealthConnect();
                  },
                  child: const Text(
                    'Instalar Health Connect',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40D9FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await HealthConnectFactory.openHealthConnectSettings();
                  },
                  child: const Text(
                    'Abrir configuración de Health Connect',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40D9FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    var result = await HealthConnectFactory.hasPermissions(
                      types,
                      readOnly: readOnly,
                    );
                    setState(() {
                      resultText = '¿Tiene permisos?: $result';
                    });
                  },
                  child: const Text(
                    '¿Tiene permisos?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40D9FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    var result = await HealthConnectFactory.requestPermissions(
                      types,
                      readOnly: readOnly,
                    );
                    setState(() {
                      resultText = 'Solicitar permisos: $result';
                    });
                  },
                  child: const Text(
                    'Solicitar permisos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40D9FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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
                        resultText += '\nTipo: ${type.name}\nResultado: $result\n';
                      });
                    }
                  },
                  child: const Text(
                    'Obtener registros',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
