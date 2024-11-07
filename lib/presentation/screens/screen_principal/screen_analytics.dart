import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
                    ElevatedButton(onPressed: () {}, child: const Text('Última Semana')),
                    ElevatedButton(onPressed: () {}, child: const Text('Último Mes')),
                    ElevatedButton(onPressed: () {}, child: const Text('Ajustes')),
                  ],
                ),
                const SizedBox(height: 16),

                // Gráfico de línea para las horas de sueño durante la semana
                const Text(
                  'Horas de sueño esta semana',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: constraints.maxWidth > 600 ? 250 : 150,
                  padding: const EdgeInsets.all(8.0),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                              return Text(days[value.toInt() % days.length]);
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots: const [
                            FlSpot(0, 7),
                            FlSpot(1, 6.5),
                            FlSpot(2, 8),
                            FlSpot(3, 6),
                            FlSpot(4, 7.5),
                            FlSpot(5, 8),
                            FlSpot(6, 7),
                          ],
                          belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Gráfico de barras para la calidad del sueño cada noche
                const Text(
                  'Calidad del sueño',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(8.0),
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                              return Text(days[value.toInt() % days.length]);
                            },
                          ),
                        ),
                      ),
                      barGroups: [
                        for (var i = 0; i < 7; i++)
                          BarChartGroupData(x: i, barRods: [
                            BarChartRodData(toY: (i + 1) * 1.1, color: Colors.blueAccent),
                          ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Gráfico circular para fases del sueño
                const Text(
                  'Fases del sueño',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(8.0),
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.blue,
                          value: 40,
                          title: 'REM',
                          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        PieChartSectionData(
                          color: Colors.green,
                          value: 30,
                          title: 'Profundo',
                          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        PieChartSectionData(
                          color: Colors.yellow,
                          value: 30,
                          title: 'Ligero',
                          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                      centerSpaceRadius: 40,
                      sectionsSpace: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Información detallada en las cards
                const Text(
                  'Resumen de gráficos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    _buildInfoCard(
                      'Promedio de horas de sueño',
                      '7 horas',
                      Icons.bedtime,
                      Colors.blue,
                      constraints,
                    ),
                    _buildInfoCard(
                      'Porcentaje de noches con sueño de buena calidad',
                      '80%',
                      Icons.nights_stay,
                      Colors.green,
                      constraints,
                    ),
                    _buildInfoCard(
                      'Distribución de fases de sueño\nREM: 40%, Profundo: 30%, Ligero: 30%',
                      'REM: 40%\nProfundo: 30%\nLigero: 30%',
                      Icons.pie_chart,
                      Colors.orange,
                      constraints,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String data, IconData icon, Color color, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth < 600 ? constraints.maxWidth / 2 - 24 : 180,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2, // Limitar a dos líneas para evitar overflow
          ),
          const SizedBox(height: 4),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topLeft,
              child: Text(
                data,
                style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
