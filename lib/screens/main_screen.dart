import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'statistics_screen.dart';
import 'settings_screen.dart';

class MainScreen
    extends StatefulWidget {
  const MainScreen(
      {super.key});

  @override
  State<MainScreen>
  createState() =>
      _MainScreenState();
}

class _MainScreenState
    extends State<MainScreen> {

  int index = 0;

  final pages = const [
    HomeScreen(),
    StatisticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      body: pages[index],

      bottomNavigationBar:
      NavigationBar(
        selectedIndex: index,

        onDestinationSelected:
            (value) {
          setState(() {
            index = value;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon:
            Icon(Icons.bar_chart),
            label: "Statistics",
          ),

          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}