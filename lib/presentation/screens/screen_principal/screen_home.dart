import 'package:flutter/material.dart';

class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({super.key});

  @override
  _ScreenHomePageState createState() => _ScreenHomePageState();
}

class _ScreenHomePageState extends State<ScreenHomePage> {
  double _sliderValue = 0.5;
  late DateTime _currentDate;
  late List<DateTime> _daysInMonth;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                      'Fulanitoo',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 30),
            // Pregunta de descanso
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text('¿Te sentiste descansado después de dormir?', 
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.sentiment_dissatisfied, color: Colors.red),
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
                      Icon(Icons.sentiment_satisfied, color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Calendario Horizontal
            Text(
              'Calendario',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _daysInMonth.map((date) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Text(
                          '${date.day}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'][date.weekday - 1],
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            // Datos de sueño
            Text(
              'Datos de sueño',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      List<Map<String, String>> sleepData = [
                        {'data': '85%', 'label': 'Calidad de sueño'},
                        {'data': '7h', 'label': 'Tiempo de sueño'},
                        {'data': '2 veces', 'label': 'Despertares nocturnos'},
                      ];
                      return SleepDataCard(
                        data: sleepData[index]['data']!,
                        label: sleepData[index]['label']!,
                      );
                    },
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(3, (index) {
                        List<Map<String, String>> sleepData = [
                          {'data': '85%', 'label': 'Calidad de sueño'},
                          {'data': '7h', 'label': 'Tiempo de sueño'},
                          {'data': '2 veces', 'label': 'Despertares nocturnos'},
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            width: 150, 
                            child: SleepDataCard(
                              data: sleepData[index]['data']!,
                              label: sleepData[index]['label']!,
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 40),
            // Botón de "Empezar a dormir"
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.nightlight_round),
                label: Text('Empezar a dormir'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 20),
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

  SleepDataCard({required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          if (label.isNotEmpty)
            Text(label, style: TextStyle(fontSize: 16, color: Colors.black54)),
        ],
      ),
    );
  }
}
