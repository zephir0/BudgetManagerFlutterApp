import 'package:budget_manager_flutter/api/user_json_service.dart';
import 'package:budget_manager_flutter/utils/success_message.dart';
import 'package:flutter/material.dart';

class ChangePassword {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();
  bool _verifyPassword = true;

  Future changePassword(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              backgroundColor: Color.fromARGB(255, 64, 52, 240),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.63,
                  child: Column(
                    children: [_pageTitle(), _formField(context, setState)],
                  )),
            );
          });
        });
  }

  Widget _pageTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Text(
        "Change your password",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _formField(BuildContext context, StateSetter setState) {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: Column(
            children: [
              _verifyPassword == false
                  ? Text(
                      "Your old password is incorrect",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              _passwordLabel("Enter your old password here"),
              _passwordInput(
                _oldPasswordController,
                (value) {
                  if (value!.isEmpty) {
                    return "Your old password cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              _passwordLabel("Enter your new password here"),
              _passwordInput(
                _newPasswordController,
                (value) {
                  if (value!.isEmpty) {
                    return "Your new password cannot be empty";
                  } else if (value == _oldPasswordController.text) {
                    return "Your new password cannot be the same as your old";
                  } else {
                    return null;
                  }
                },
              ),
              _passwordLabel("Confirm your new password"),
              _passwordInput(
                _confirmNewPasswordController,
                (value) {
                  if (value!.isEmpty) {
                    return "Please confirm your new password";
                  } else if (value != _newPasswordController.text) {
                    return "Your new password and confirm password must match";
                  } else {
                    return null;
                  }
                },
              ),
              _saveButton(context, setState)
            ],
          ),
        ),
      ),
    );
  }

  Text _passwordLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _passwordInput(
    TextEditingController textEditingController,
    String? Function(String?) validator,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          errorStyle: TextStyle(color: Colors.white, fontSize: 10),
        ),
        style: TextStyle(),
        controller: textEditingController,
        validator: validator,
      ),
    );
  }

  Widget _saveButton(BuildContext context, StateSetter setState) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 71, 139, 228),
            minimumSize: Size(40, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () async {
          if (formkey.currentState!.validate()) {
            bool result = await UserJsonService().changePassword(
                _oldPasswordController.text, _newPasswordController.text);
            if (result) {
              SuccessMessageAfterSubmit()
                  .successMessage("Your password was successfully changed");
              Future.delayed(Duration(seconds: 3), () {
                Navigator.pop(context);
              });
            } else {
              setState(() {
                _verifyPassword = false;
              });
            }
          }
        },
        child: Text(
          "SAVE",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ));
  }
}
