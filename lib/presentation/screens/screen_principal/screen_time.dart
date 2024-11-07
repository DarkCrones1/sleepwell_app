import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ScreenTimePage extends StatefulWidget {
  const ScreenTimePage({super.key});

  @override
  State<ScreenTimePage> createState() => _ScreenTimePageState();
}

class _ScreenTimePageState extends State<ScreenTimePage> {
  late Timer _timer;
  DateTime _startTime = DateTime.now();
  DateTime? _alarmTime;
  String _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
  Duration _elapsedSleepTime = Duration.zero;

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Configuración inicial de las notificaciones
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: androidSettings);
    _localNotificationsPlugin.initialize(initializationSettings);

    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  void _updateTime(Timer timer) {
    setState(() {
      _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
      _elapsedSleepTime = DateTime.now().difference(_startTime);
    });
    _checkAlarm();
  }

  void _checkAlarm() {
    if (_alarmTime != null && DateTime.now().isAfter(_alarmTime!)) {
      _showAlarmNotification();
      _alarmTime = null; // Resetea la alarma después de activarla
    }
  }

  Future<void> _showAlarmNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'alarm_channel',
      'Alarm Notifications',
      channelDescription: 'Channel for alarm notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0,
      'Alarma de sueño',
      'Es hora de despertar',
      notificationDetails,
    );
  }

  void _setAlarmTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _alarmTime = DateTime(
          _startTime.year,
          _startTime.month,
          _startTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hoursSlept = _elapsedSleepTime.inHours;
    final minutesSlept = _elapsedSleepTime.inMinutes.remainder(60);
    final timeUntilAlarm = _alarmTime != null
        ? _alarmTime!.difference(DateTime.now())
        : Duration.zero;
    final alarmSet = _alarmTime != null && timeUntilAlarm.inSeconds > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento del sueño'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Seguimiento del sueño',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              _currentTime,
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            Text(
              '${hoursSlept.toString().padLeft(2, '0')}:${minutesSlept.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.pause, size: 40),
              onPressed: () {
                setState(() {
                  _startTime = DateTime.now();
                });
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '$hoursSlept hrs',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Text('Tiempo'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        alarmSet
                            ? '${timeUntilAlarm.inHours} h ${timeUntilAlarm.inMinutes.remainder(60)} min'
                            : 'No programada',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Text('Para la alarma'),
                    ],
                  ),
                  const Column(
                    children: [
                      Text('85%', style: TextStyle(fontSize: 18)),
                      Text('Calidad'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Alarma',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _setAlarmTime,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.alarm, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          _alarmTime != null
                              ? DateFormat('hh:mm a').format(_alarmTime!)
                              : 'No programada',
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Text(
                      alarmSet
                          ? 'Alarma en ${timeUntilAlarm.inHours} h ${timeUntilAlarm.inMinutes.remainder(60)} min'
                          : '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Desglose',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const SleepStageBar(label: 'Profundo', percentage: 85),
            const SleepStageBar(label: 'Ligero', percentage: 66),
            const SleepStageBar(label: 'REM', percentage: 70),
          ],
        ),
      ),
    );
  }
}

class SleepStageBar extends StatelessWidget {
  final String label;
  final int percentage;

  const SleepStageBar(
      {super.key, required this.label, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage / 100,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
