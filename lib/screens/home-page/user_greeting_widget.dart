import 'package:flutter/material.dart';

import '../../api/json_service.dart';
import '../../model/user.dart';

class UserGreetingWidget {
  Padding userWelcomeMessage(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
        child: FutureBuilder(
            future: JsonService().getUser(),
            builder: (BuildContext buildContext, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                User? user = snapshot.data;
                return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color.fromARGB(255, 53, 125, 184),
                                Color.fromRGBO(59, 59, 90, 1)
                              ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Welcome, ${user?.login}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
