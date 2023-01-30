// ignore_for_file: invalid_use_of_protected_member

import 'package:budget_manager_flutter/api/ticket_json_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TicketCreatingForm {
  Form createTicket(
      BuildContext buildContext,
      GlobalKey<FormState> formKey,
      TextEditingController subjectController,
      TextEditingController messageController) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: subjectController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              } else if (subjectController.text.length > 40) {
                return 'You title is too long, please enter maximum 40 characters.';
              } else
                return null;
            },
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
            controller: messageController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a subtitle';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Subtitle',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                TicketJsonService().createTicket(
                    subjectController.text, messageController.text);
                showSuccessMessage();
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.pushNamed(buildContext, '/ticketScreen');
                });
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  showSuccessMessage() {
    Fluttertoast.showToast(
        msg: "Form submitted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
