import 'package:flutter/material.dart';
import 'package:sleepwell_app/presentation/screens/screen_principal/screen_analytics.dart';
import 'package:sleepwell_app/presentation/screens/screen_principal/screen_commends.dart';
import 'package:sleepwell_app/presentation/screens/screen_principal/screen_home.dart';
import 'package:sleepwell_app/presentation/screens/screen_principal/screen_profile.dart';
import 'package:sleepwell_app/presentation/screens/screen_principal/screen_time.dart';

class ScreenNavbar extends StatefulWidget {
  const ScreenNavbar({super.key});

  @override
  State<ScreenNavbar> createState() => _ScreenNavbarState();
}

class _ScreenNavbarState extends State<ScreenNavbar> {

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.access_time), label: 'Horario' ),
          NavigationDestination(icon: Icon(Icons.category), label: 'Recomendaciones' ),
          NavigationDestination(icon: Icon(Icons.home_filled), label: 'Inicio' ),
          NavigationDestination(icon: Icon(Icons.analytics), label: 'Analisis' ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Perfil' ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const ScreenTimePage(),
        ),
        Container(
          alignment: Alignment.center,
          child: const ScreenCommendsPage() ,
        ),
        Container(
          alignment: Alignment.center,
          child: const ScreenHomePage() ,
        ),
        Container(
          alignment: Alignment.center,
          child: const ScreenAnalyticsPage() ,
        ),
        Container(
          alignment: Alignment.center,
          child: const ScreenProfilePage() ,
        ),
      ][currentPageIndex],
    );
  }
}