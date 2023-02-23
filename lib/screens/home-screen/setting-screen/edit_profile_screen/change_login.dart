import 'package:budget_manager_flutter/api/user_json_service.dart';
import 'package:budget_manager_flutter/utils/success_message.dart';
import 'package:flutter/material.dart';

class ChangeLogin {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _newLogin = TextEditingController();
  TextEditingController _userPassword = TextEditingController();

  Future changeLogin(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Color.fromARGB(255, 64, 52, 240),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      _pageTitle(),
                      _pageLabel("Enter your new login here"),
                      _formBuild(_newLogin, ((value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your new login";
                        } else if (value.length > 15) {
                          return "Your login must be no more than 15 characters";
                        } else if (_newLogin.text == _userPassword.text) {
                          return "Your login and password must be different";
                        }
                      })),
                      _pageLabel("Write your password to confirm"),
                      _formBuild(_userPassword, (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                      }),
                      _saveButton(context),
                    ],
                  ),
                ),
              ));
        });
  }

  Widget _pageTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Text(
        "Change your password",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _pageLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _formBuild(TextEditingController textEditingController,
      String? Function(String?)? value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            style: TextStyle(fontSize: 17),
            controller: textEditingController,
            validator: value,
          )
        ],
      ),
    );
  }

  Widget _saveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 71, 139, 228),
              minimumSize: Size(40, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              bool result = await UserJsonService()
                  .changeLogin(_newLogin.text, _userPassword.text);
              if (result) {
                SuccessMessageAfterSubmit()
                    .successMessage("Login changed successfully");
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.pop(context);
                });
              } else
                throw new Exception("Cannot change login");
            }
          },
          child: Text(
            "SAVE",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          )),
    );
  }
}
