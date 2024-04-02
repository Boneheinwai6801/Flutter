// ignore_for_file: unused_import

import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  saveStateInPref(state) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('state', state);
    // log("state : ${state}");
  }

  getStateFromPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var state = preferences.getString('state');
    return state;
  }

  saveUserNameInPref(username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    // log("stw : ${username}");
  }

  saveStateLanguage(state) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('lanState', state);
  }

  getStateLanguage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int? state = preferences.getInt('lanState');
    return state;
  }
}
