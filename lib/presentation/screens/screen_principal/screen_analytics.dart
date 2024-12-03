// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:sleepwell_app/Infrastructure/models/response/data_dream_response.dart';
import 'package:sleepwell_app/providers/data_dream_providers/data_dream_provider.dart';

class ScreenAnalyticsPage extends StatefulWidget {
  const ScreenAnalyticsPage({super.key});

  @override
  _ScreenAnalyticsPageState createState() => _ScreenAnalyticsPageState();
}

class _ScreenAnalyticsPageState extends State<ScreenAnalyticsPage> {
  int _pageSize = 7; // Valor por defecto

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
      body: Consumer<DataDreamProvider>(
        builder: (context, dataDreamProvider, child) {
          if (dataDreamProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final data =
              dataDreamProvider.dataDream!; // Usamos un valor no nulo aquí

          // Mapeo de horas de sueño profundo para el gráfico
          final sleepDurations =
              data.map((item) => item.deepSleepHours.toDouble()).toList();
          // Mapeo de calidad del sueño para el gráfico
          final qualityScores = data
              .map((item) =>
                  _mapSleepQualityToScore(item.sleepQualityStatusName))
              .toList();

          // Contar cuántos días corresponden a cada calidad de sueño
          final qualityCount = _countSleepQualityStatus(data);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Selector de cantidad de días (pageSize)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Selecciona cantidad de días: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.blue.shade400, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: DropdownButton<int>(
                        value: _pageSize,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.blue),
                        elevation: 16,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        underline: Container(),
                        onChanged: (newPageSize) {
                          if (newPageSize != null) {
                            setState(() {
                              _pageSize = newPageSize;
                            });
                            dataDreamProvider.getDataDream(
                              pageSize: newPageSize,
                            ); // Recargar los datos con el nuevo pageSize
                          }
                        },
                        items: [3, 7, 15, 25].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value días'),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Gráfico de línea para las horas de sueño durante la semana
                const Text(
                  'Horas de sueño esta semana',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 250,
                  padding: const EdgeInsets.all(8.0),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles:
                              SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = [
                                'Lun',
                                'Mar',
                                'Mié',
                                'Jue',
                                'Vie',
                                'Sáb',
                                'Dom'
                              ];
                              return Text(days[value.toInt() % days.length]);
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots: sleepDurations
                              .asMap()
                              .map((i, e) =>
                                  MapEntry(i, FlSpot(i.toDouble(), e)))
                              .values
                              .toList(),
                          belowBarData: BarAreaData(
                              show: true, color: Colors.blue.withOpacity(0.2)),
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
                  height: 250,
                  padding: const EdgeInsets.all(8.0),
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles:
                              SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = [
                                'Lun',
                                'Mar',
                                'Mié',
                                'Jue',
                                'Vie',
                                'Sáb',
                                'Dom'
                              ];
                              return Text(days[value.toInt() % days.length]);
                            },
                          ),
                        ),
                      ),
                      barGroups: qualityScores
                          .asMap()
                          .map((i, score) => MapEntry(
                              i,
                              BarChartGroupData(x: i, barRods: [
                                BarChartRodData(
                                    toY: score.toDouble(),
                                    color: Colors.blueAccent),
                              ])))
                          .values
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Gráfico circular para mostrar la distribución de calidad del sueño
                const Text(
                  'Distribución de la calidad del sueño',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 250,
                  padding: const EdgeInsets.all(8.0),
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 50,
                      sections: _buildQualityStatusChart(qualityCount),
                    ),
                  ),
                ),
                // Tarjetas con estadísticas clave
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    _buildInfoCard(
                      'Promedio de horas de sueño',
                      '${_calculateAverageSleepHours(data).toStringAsFixed(1)} horas',
                      Icons.bedtime,
                      Colors.blue,
                    ),
                    _buildInfoCard(
                      'Porcentaje de noches con buena calidad',
                      '${_calculateGoodQualityPercentage(data)}%',
                      Icons.nights_stay,
                      Colors.green,
                    ),
                    _buildInfoCard(
                      'Distribución de fases de sueño',
                      _calculateSleepPhaseDistribution(data),
                      Icons.pie_chart,
                      Colors.orange,
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

  Widget _buildInfoCard(String title, String data, IconData icon, Color color) {
    return Container(
      width: 180,
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
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topLeft,
              child: Text(
                data,
                style: TextStyle(
                    fontSize: 14, color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Mapeo de la calidad del sueño a un valor numérico
  int _mapSleepQualityToScore(String sleepQuality) {
    switch (sleepQuality) {
      case 'Excelente':
        return 1;
      case 'Buena':
        return 2;
      case 'Regular':
        return 3;
      case 'Mala':
        return 4;
      default:
        return 0; // Si no se reconoce, asignamos 0
    }
  }

  // Función para contar cuántos días tuvieron cada tipo de calidad de sueño
  Map<String, int> _countSleepQualityStatus(List<DataDreamResponseDto> data) {
    final qualityCount = <String, int>{};

    for (var item in data) {
      final quality = item.sleepQualityStatusName;
      qualityCount[quality] = (qualityCount[quality] ?? 0) + 1;
    }

    return qualityCount;
  }

  // Función para crear los datos de las secciones del gráfico circular
  List<PieChartSectionData> _buildQualityStatusChart(
      Map<String, int> qualityCount) {
    final total = qualityCount.values.reduce((a, b) => a + b);

    return qualityCount.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      return PieChartSectionData(
        value: percentage,
        color: _getColorForQuality(entry.key),
        title: '${entry.value} días',
        radius: 80, // Un radio mayor para hacerlo más grande y visible
        titleStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        borderSide: BorderSide(
          color: Colors.white
              .withOpacity(0.5), // Agregar borde suave para simular pastel
          width: 2, // Ancho del borde
        ),
        showTitle: true, // Mostrar el título en cada sección
      );
    }).toList();
  }

  // Asignar colores según la calidad del sueño
  Color _getColorForQuality(String quality) {
    switch (quality) {
      case 'Excelente':
        return Colors.green;
      case 'Buena':
        return Colors.blue;
      case 'Regular':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

// Calcula el promedio de horas de sueño
// Calcula el promedio de horas de sueño
double _calculateAverageSleepHours(List<DataDreamResponseDto> data) {
  if (data.isEmpty) return 0.0;
  final totalHours = data.fold(0.0, (sum, item) => sum + item.deepSleepHours);
  return totalHours / data.length;
}

// Calcula el porcentaje de noches con buena calidad de sueño
int _calculateGoodQualityPercentage(List<DataDreamResponseDto> data) {
  if (data.isEmpty) return 0;

  // Consideramos "Buena" y "Excelente" como buenas calidades
  final goodQualityCount = data.where((item) {
    return item.sleepQualityStatusName == 'Buena' ||
        item.sleepQualityStatusName == 'Excelente';
  }).length;

  return ((goodQualityCount / data.length) * 100).round();
}

// Calcula la distribución de las fases de sueño: Profundo y No Profundo
String _calculateSleepPhaseDistribution(List<DataDreamResponseDto> data) {
  if (data.isEmpty) return "Sin datos";

  int deepSleepCount = 0;
  int totalSleepCount = 0;

  for (var item in data) {
    deepSleepCount += item.deepSleepHours.round();
    totalSleepCount +=
        (item.durationMinutes / 60).round(); // Total de horas de sueño
  }

  if (totalSleepCount == 0) return "Sin datos";

  final deepPercentage = ((deepSleepCount / totalSleepCount) * 100).round();
  final nonDeepPercentage = 100 - deepPercentage;

  return "Profundo: $deepPercentage%, No Profundo: $nonDeepPercentage%";
}
