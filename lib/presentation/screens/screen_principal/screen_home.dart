import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepwell_app/presentation/screens/screen_principal/screen_time.dart';
import 'package:sleepwell_app/providers/data_dream_providers/data_dream_provider.dart';

class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({super.key});

  @override
  _ScreenHomePageState createState() => _ScreenHomePageState();
}

class _ScreenHomePageState extends State<ScreenHomePage> {
  double _sliderValue = 0.5;
  late DateTime _currentDate;
  late List<DateTime> _daysInMonth;
  bool _isNotificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _daysInMonth = _getDaysInMonth(_currentDate.year, _currentDate.month);
  }

  List<DateTime> _getDaysInMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    List<DateTime> days = [];
    for (int i = 0; i <= lastDayOfMonth.day - 1; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabecera
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'SleepWell',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    _isNotificationsEnabled
                        ? Icons.notifications
                        : Icons.notifications_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isNotificationsEnabled =
                          !_isNotificationsEnabled; // Alterna el estado
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Pregunta de descanso
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '¿Te sentiste descansado después de dormir?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.sentiment_dissatisfied,
                          color: Colors.red),
                      Expanded(
                        child: Slider(
                          value: _sliderValue,
                          min: 0,
                          max: 1,
                          divisions: 10,
                          label: "Nivel de descanso",
                          onChanged: (value) {
                            setState(() {
                              _sliderValue = value;
                            });
                          },
                        ),
                      ),
                      const Icon(Icons.sentiment_satisfied,
                          color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Calendario Horizontal
            const Text(
              'Calendario',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _daysInMonth.map((date) {
                  bool isToday = date.day == _currentDate.day &&
                      date.month == _currentDate.month &&
                      date.year == _currentDate.year;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                isToday ? Colors.blue[700] : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isToday
                                  ? Colors.blue[200]!
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            boxShadow: isToday
                                ? [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.5),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isToday ? Colors.white : Colors.black,
                                  ),
                                ),
                                Text(
                                  [
                                    'Lun',
                                    'Mar',
                                    'Mié',
                                    'Jue',
                                    'Vie',
                                    'Sáb',
                                    'Dom'
                                  ][date.weekday - 1],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        isToday ? Colors.white : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            // Datos de sueño
            const Text(
              'Datos de sueño',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Consumer<DataDreamProvider>(
              builder: (context, dataDreamProvider, child) {
                if (dataDreamProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (dataDreamProvider.dataDream == null ||
                    dataDreamProvider.dataDream!.isEmpty) {
                  return const Text("No hay datos de sueño disponibles.");
                }

                final sleepData = dataDreamProvider.dataDream!.last;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          List<Map<String, String>> sleepDataMapped = [
                            {
                              'data': sleepData.sleepQualityStatusName,
                              'label': 'Calidad de sueño'
                            },
                            {
                              'data': '${sleepData.deepSleepHours}h',
                              'label': 'Sueño profundo'
                            },
                            {
                              'data': '${sleepData.interruptions} veces',
                              'label': 'Despertares nocturnos'
                            },
                          ];
                          return SleepDataCard(
                            data: sleepDataMapped[index]['data']!,
                            label: sleepDataMapped[index]['label']!,
                          );
                        },
                      );
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(3, (index) {
                            List<Map<String, String>> sleepDataMapped = [
                              {
                                'data': sleepData.sleepQualityStatusName,
                                'label': 'Calidad de sueño'
                              },
                              {
                                'data': '${sleepData.deepSleepHours}h',
                                'label': 'Sueño profundo'
                              },
                              {
                                'data': '${sleepData.interruptions} veces',
                                'label': 'Despertares nocturnos'
                              },
                            ];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                width: 200,
                                child: SleepDataCard(
                                  data: sleepDataMapped[index]['data']!,
                                  label: sleepDataMapped[index]['label']!,
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 40),
            // Botón de "Empezar a dormir"
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navegar a la página de ScreenTime
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenTimePage()),
                  );
                },
                icon: const Icon(Icons.nightlight_round),
                label: const Text('Empezar a dormir'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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

class SleepDataCard extends StatelessWidget {
  final String data;
  final String label;

  const SleepDataCard({super.key, required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(0.2),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
