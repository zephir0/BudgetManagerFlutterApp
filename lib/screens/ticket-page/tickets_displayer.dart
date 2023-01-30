import 'package:budget_manager_flutter/api/ticket_json_service.dart';
import 'package:flutter/material.dart';

import '../../model/ticket.dart';
import '../chat-page/chat_screen.dart';

class TicketsDisplayer {
  SizedBox showAllTickets(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.60,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.zero,
          child: FutureBuilder(
              future: TicketJsonService().getAllTickets(),
              builder: (BuildContext buildContext,
                  AsyncSnapshot<List<Ticket>> snapshot) {
                if (snapshot.hasData) {
                  List<Ticket>? ticketList = snapshot.data;
                  List<Widget> tickets = [];
                  for (var ticket in ticketList!.reversed) {
                    tickets.add(new Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Center(
                                  child: showTicket(
                                      buildContext, ticket.createdAt, ticket))),
                        )
                      ],
                    ));
                  }
                  return Column(
                    children: tickets,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  Padding showTicket(
      BuildContext buildContext, String ticketSubject, Ticket ticket) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Center(
        child: InkWell(
          child: Container(
            height: MediaQuery.of(buildContext).size.height * 0.08,
            width: MediaQuery.of(buildContext).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 53, 142, 201),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Icon(
                      Icons.sms,
                      color: Colors.white,
                    ),
                  ),
                  Center(
                      child: Text(
                    ticketSubject,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
                buildContext,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          ticket: ticket,
                        )));
          },
        ),
      ),
    );
  }
}
