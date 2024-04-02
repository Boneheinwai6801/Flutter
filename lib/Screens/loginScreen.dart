// ignore_for_file: file_names

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/homePage.dart';
import 'package:flutter_application_1/data/preferences.dart';
import 'package:lottie/lottie.dart';

import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignInAccount? _currentUser;
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      Preferences().saveStateInPref('1');
      Preferences().saveUserNameInPref(_currentUser!.displayName);
    } catch (error) {
      log('message');
      log(error.toString());
    }
  }

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((event) {
      setState(() {
        _currentUser = event;
        log(_currentUser.toString());
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
                border: Border.symmetric(),
              ),
              child: Lottie.network(
                  'https://lottie.host/c33b9c79-7145-48e4-b891-4541d575a378/4V7VF98Dvy.json',
                  width: 150,
                  height: 200)
              // child: Image.asset('assets/images/mit.png',width: 200,height: 200,),

              ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
              ),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: InkWell(
                onTap: () {
                  _handleSignIn();

                  if (_currentUser!.email.isNotEmpty) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MyHomePage(_currentUser)),
                      ((route) => false),
                    );
                  }
                },
                child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.jpg',
                            width: 30,
                            height: 20,
                          ),
                          Text("signin".tr()),
                        ],
                      ),
                    )),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
