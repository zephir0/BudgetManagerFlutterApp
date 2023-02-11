import 'package:budget_manager_flutter/api/budget_json_service.dart';
import 'package:budget_manager_flutter/model/budget_type.dart';
import 'package:budget_manager_flutter/screens/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/budget.dart';
import '../../utils/formatting_numbers.dart';
import '../statistics-screen/transaction_dispayer.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  bool _showCalendar = true;
  String _selectedDay = DateTime.now().toString().split(" ").first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalVariables().backgroundGradient),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
                child: Text(
                  "Calendar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 65,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _showCalendar
                          ? TableCalendar(
                              headerStyle:
                                  HeaderStyle(formatButtonShowsNext: false),
                              weekNumbersVisible: true,
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _showCalendar = false;
                                  _selectedDay =
                                      selectedDay.toString().split(" ").first;
                                });
                                selectedDay.toString().split(" ").first;
                              },
                              firstDay: DateTime.parse("2023-01-29"),
                              focusedDay: DateTime.now(),
                              lastDay: DateTime.parse("2023-04-29"),
                            )
                          : ListView(
                              children: [
                                Center(
                                  child: Text(
                                    _selectedDay,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: FutureBuilder(
                                    future: BudgetJsonService()
                                        .getBudgetHistoryByDate(_selectedDay),
                                    builder: (BuildContext buildContext,
                                        AsyncSnapshot<List<Budget>> snapshot) {
                                      if (snapshot.hasData) {
                                        List<Budget>? budgetHistory =
                                            snapshot.data;
                                        return Column(
                                          children: [
                                            for (var budget in budgetHistory!)
                                              GestureDetector(
                                                onTap: () {
                                                  TransactionDisplayer()
                                                      .showDetailsDialog(
                                                          context,
                                                          budget,
                                                          budget.budgetType!);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          3, 5, 3, 5),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          color:
                                                              budget.budgetType ==
                                                                      BudgetType
                                                                          .INCOME
                                                                  ? Colors.green
                                                                  : Colors.red),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                budget.budgetType ==
                                                                        BudgetType
                                                                            .INCOME
                                                                    ? budget
                                                                        .incomeCategory
                                                                        .toString()
                                                                        .split(
                                                                            ".")
                                                                        .last
                                                                    : budget
                                                                        .expenseCategory
                                                                        .toString()
                                                                        .split(
                                                                            ".")
                                                                        .last,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      10,
                                                                      0),
                                                              child: Text(
                                                                "${NumberFormatter().getFormattedNumber(budget.value!.toDouble())}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              ),
                                          ],
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  )),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: CircleBorder(),
                ),
                autofocus: true,
                onPressed: () {
                  _showCalendar == true
                      ? Navigator.pop(context)
                      : setState(() {
                          _showCalendar = true;
                        });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_outlined,
                    size: 45,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
