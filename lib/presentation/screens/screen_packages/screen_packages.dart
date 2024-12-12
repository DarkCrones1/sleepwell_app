// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class ScreenPackages extends StatefulWidget {
  const ScreenPackages({super.key});

  @override
  _ScreenPackagesState createState() => _ScreenPackagesState();
}

class _ScreenPackagesState extends State<ScreenPackages> {
  bool isStandard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paquetes para el Sueño"),
        backgroundColor: isStandard ? Colors.lightBlueAccent : Colors.amber,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card para el paquete estándar
                PackageCard(
                  title: "Paquete Estándar",
                  subtitle: "Ideal para comenzar",
                  description:
                      "Accede a herramientas básicas para monitorear tu sueño y obtener estadísticas esenciales.",
                  features: const [
                    "Monitorización básica del sueño",
                    "Estadísticas diarias",
                    "Gratis para siempre"
                  ],
                  color: Colors.lightBlueAccent,
                  icon: Icons.bedtime,
                  buttonText: "Usar ahora",
                  onPressed: () {
                    setState(() {
                      isStandard = true;
                    });
                  },
                ),
                SizedBox(height: 16),
                // Card para el paquete premium
                PackageCard(
                  title: "Paquete Premium",
                  subtitle: "Máximo confort y análisis avanzado",
                  description:
                      "Incluye análisis avanzados con IA, bitácoras personalizadas, recomendaciones para mejorar tu sueño y más.",
                  features: const [
                    "Análisis avanzado con IA",
                    "Bitácora personalizada",
                    "Recomendaciones avanzadas",
                    "Monitoreo en tiempo real"
                  ],
                  color: Colors.amber,
                  icon: Icons.star,
                  buttonText: "Suscribirse",
                  onPressed: () {
                    setState(() {
                      isStandard = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
  final Color color;
  final IconData icon;
  final String buttonText;
  final VoidCallback onPressed;

  const PackageCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.color,
    required this.icon,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  child: Icon(icon, color: Colors.white),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(
              "Características:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ...features.map(
              (feature) => Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
                  SizedBox(width: 8),
                  Text(feature),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
