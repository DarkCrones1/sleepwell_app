import 'package:flutter/material.dart';

class ScreenCommendsPage extends StatelessWidget {
  const ScreenCommendsPage({super.key});

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
                  backgroundColor: Colors.blue[200],
                  child: const Text("icon", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Primera sección de slider
            const SectionTitle(titulo: "Título"),
            const SliderDeCards(),

            const SizedBox(height: 20),

            // Segunda sección de slider
            const SectionTitle(titulo: "Título"),
            const SliderDeCards(),

            const SizedBox(height: 20),

            // Sección de cards individuales
            const SectionTitle(titulo: "Título"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => Card(
                  color: Colors.grey[300],
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("card"),
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

// Widget para el título de cada sección
class SectionTitle extends StatelessWidget {
  final String titulo;

  const SectionTitle({required this.titulo});

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
  const SliderDeCards();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          3,
          (index) => Container(
            width: 120,
            margin: const EdgeInsets.only(right: 16),
            color: Colors.grey[300],
            child: const Center(child: Text("slider de card")),
          ),
        ),
      ),
    );
  }
}
