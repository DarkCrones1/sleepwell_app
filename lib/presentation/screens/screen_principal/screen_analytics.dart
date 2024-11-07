import 'package:flutter/material.dart';

class ScreenAnalyticsPage extends StatelessWidget {
  const ScreenAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Análisis de los datos',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.bold, 
          ),
        ),
        actions: const [],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Botones superiores
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text('Botón')),
                    ElevatedButton(onPressed: () {}, child: const Text('Botón')),
                    ElevatedButton(onPressed: () {}, child: const Text('Botón'))
                  ],
                ),
                const SizedBox(height: 16),

                // Primera gráfica
                Container(
                  height: constraints.maxWidth > 600 ? 250 : 150,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text('Gráfica'),
                ),
                const SizedBox(height: 16),

                // Gráficas pequeñas
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        height: 100,
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Text('Gráfica'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Container(
                        height: 100,
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Text('Gráfica'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Información detallada
                const Text(
                  'Información detallada',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 150,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text('Card con info'),
                ),
                const SizedBox(height: 8),

                // Recomendaciones
                const Text(
                  'Recomendaciones',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    return Container(
                      width: (constraints.maxWidth - 48) / 3,
                      height: 100,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Text('Card'),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
