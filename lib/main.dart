import 'dart:async';

import 'package:budget_manager_flutter/screens/home-page/home_screen.dart';
import 'package:budget_manager_flutter/screens/login-page/login_screen.dart';
import 'package:budget_manager_flutter/screens/setting-page/setting_screen.dart';
import 'package:budget_manager_flutter/screens/ticket-page/ticket_creation_screen.dart';
import 'package:budget_manager_flutter/screens/ticket-page/ticket_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Budget Manager",
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/settings': (context) => SettingScreen(),
        '/ticketScreen': (context) => TicketScreen(),
        '/ticketCreationScreen': (context) => TicketCreationScreen()
      },
      home: LoginScreen(),
    );
  }
}
