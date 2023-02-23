import 'package:budget_manager_flutter/screens/home-screen/setting-screen/ticket-screen/ticket_creation_screen.dart';
import 'package:budget_manager_flutter/screens/home-screen/setting-screen/ticket-screen/tickets_displayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global_variables.dart';

class TicketScreen extends StatefulWidget {
  final GlobalKey<TicketScreenState> _key = GlobalKey<TicketScreenState>();

  @override
  State<StatefulWidget> createState() => TicketScreenState();
}

class TicketScreenState extends State<TicketScreen> {
  final GlobalKey<TicketScreenState> _key = GlobalKey<TicketScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration:
              BoxDecoration(gradient: GlobalVariables().backgroundGradient),
          child: ListView(children: [
            ticketSreenTitle(),
            Divider(
              color: Color.fromARGB(181, 255, 255, 255),
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
            ),
            TicketsDisplayer().showAllTickets(context),
          ]),
        ),
        floatingActionButton: createTicketButton(context),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndFloat);
  }

  Padding ticketSreenTitle() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(10, 45, 100, 13),
      child: Center(
        child: Container(
          decoration: BoxDecoration(),
          child: Text(
            "YOUR TICKETS",
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Padding createTicketButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 45),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TicketCreationScreen()));
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 29, 94, 168),
          shape: CircleBorder(),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 75,
        ),
      ),
    );
  }
}
