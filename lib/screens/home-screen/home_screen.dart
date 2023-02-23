// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_manager_flutter/screens/home-screen/budget_creation_widget.dart';
import 'package:flutter/material.dart';

import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/home-screen/balance_display.dart';
import 'package:budget_manager_flutter/screens/home-screen/budget_items_display.dart';
import 'package:budget_manager_flutter/screens/home-screen/home_menu_bar.dart';
import 'package:budget_manager_flutter/screens/home-screen/user_greeting_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: GlobalVariables().backgroundGradient),
      child: ListView(
        children: [
          UserGreetingWidget().userWelcomeMessage(context),
          BalanceDisplay().showBalanceScreen(context),
          BudgetCreationWidget().createBudget(context),
          HomeMenuBar().menuBar(context),
          mostRecent(context),
          BudgetItemsDisplayer().mostRecentItems(context)
        ],
      ),
    ));
  }

  Padding mostRecent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 10, 10),
      child: Text(
        "Most recent",
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
