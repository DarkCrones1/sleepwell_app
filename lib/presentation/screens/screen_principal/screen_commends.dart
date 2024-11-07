import 'package:flutter/material.dart';

class ScreenCommendsPage extends StatefulWidget {
  const ScreenCommendsPage({super.key});

  @override
  _ScreenCommendsPageState createState() => _ScreenCommendsPageState();
}

class _ScreenCommendsPageState extends State<ScreenCommendsPage> {
  final List<String> recomendacionesSueno = const [
    "Evita el uso de dispositivos electrónicos una hora antes de dormir.",
    "Mantén una rutina de sueño constante, incluso los fines de semana.",
    "Realiza ejercicio regularmente, pero evita hacerlo antes de dormir.",
    "Crea un ambiente oscuro y silencioso en tu habitación.",
    "Limita el consumo de cafeína en la tarde."
  ];

  // Lista de ajustes rápidos
  final List<String> ajustesRapidos = [
    "Activar modo nocturno",
    "Reducir notificaciones",
    "Establecer recordatorio para dormir"
  ];

  int currentAjusteIndex = 0;

  void cambiarAjuste() {
    setState(() {
      currentAjusteIndex = (currentAjusteIndex + 1) % ajustesRapidos.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recomendaciones',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Iconos en la parte superior
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue[300],
                  child: const Icon(Icons.nights_stay, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Primera sección de slider con recomendaciones
            const SectionTitle(titulo: "Recomendaciones para mejorar el sueño"),
            SliderDeCards(recomendaciones: recomendacionesSueno),

            const SizedBox(height: 20),

            // Segunda sección de slider
            const SectionTitle(titulo: "Consejos adicionales"),
            SliderDeCards(recomendaciones: recomendacionesSueno),

            const SizedBox(height: 20),

            // Sección de acciones rápidas con cambio de ajuste
            const SectionTitle(titulo: "Acciones rápidas"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.teal[100],
                    child: InkWell(
                      onTap: cambiarAjuste,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.settings, size: 40, color: Colors.teal),
                            const SizedBox(height: 10),
                            Text(
                              ajustesRapidos[currentAjusteIndex],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para el título de cada sección
class SectionTitle extends StatelessWidget {
  final String titulo;

  const SectionTitle({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        titulo,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Widget para el slider de cards
class SliderDeCards extends StatelessWidget {
  final List<String> recomendaciones;

  const SliderDeCards({super.key, required this.recomendaciones});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recomendaciones.length,
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bedtime, color: Colors.blue, size: 30),
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    recomendaciones[index],
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
