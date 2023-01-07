import 'package:budget_manager_flutter/api/api_service.dart';
import 'package:budget_manager_flutter/api/json_service.dart';
import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:budget_manager_flutter/screens/home-page/balance_display.dart';
import 'package:budget_manager_flutter/screens/home-page/budget_adding.dart';
import 'package:budget_manager_flutter/screens/home-page/budget_adding_menu.dart';
import 'package:budget_manager_flutter/screens/home-page/budget_editing_menu.dart';
import 'package:budget_manager_flutter/screens/home-page/budget_items_display.dart';
import 'package:budget_manager_flutter/screens/home-page/menubar/home_menu_bar.dart';
import 'package:budget_manager_flutter/screens/home-page/slide_widget.dart';
import 'package:budget_manager_flutter/screens/home-page/user_greeting_widget.dart';
import 'package:flutter/material.dart';
import '../../model/budget.dart';
import '../../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
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
          BudgetAdder().incomeOrExpense(context),
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
