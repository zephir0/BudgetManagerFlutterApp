import 'package:budget_manager_flutter/screens/ticket-page/ticket_creating_form.dart';
import 'package:flutter/material.dart';

class TicketCreationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TicketCreationScreenState();
}

class TicketCreationScreenState extends State<TicketCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Ticket'),
        ),
        body: ListView(
          children: [
            TicketCreatingForm().createTicket(
                context, _formKey, _subjectController, _messageController),
          ],
        ));
  }
}
