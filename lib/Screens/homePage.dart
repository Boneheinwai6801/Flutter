// ignore_for_file: file_names, must_be_immutable, prefer_final_fields

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/countryList.dart';
import 'package:flutter_application_1/Screens/movieList.dart';
import 'package:flutter_application_1/Screens/profile.dart';
import 'package:flutter_application_1/Screens/q&aScreen.dart';
import 'package:flutter_application_1/Screens/shoopingScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  GoogleSignInAccount? _currentUser;
  MyHomePage(this._currentUser, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String greeting = '';

  @override
  void initState() {
    super.initState();
    _updateGreeting();
    log(greeting);
  }

  void _updateGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (hour < 17) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        greeting = 'Good Evening';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 143, 191, 228),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(widget._currentUser!.displayName.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text(greeting,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                  trailing: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(widget._currentUser!)),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          widget._currentUser!.photoUrl.toString()),
                    ),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 143, 191, 228),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard("country".tr(), Icons.language_rounded,
                      Colors.deepOrange, const CountryList()),
                  itemDashboard("video".tr(), CupertinoIcons.play_rectangle,
                      Colors.green, const MovieList()),
                  itemDashboard("q&a".tr(), CupertinoIcons.chat_bubble_2,
                      Colors.purple, const QuestionScreen()),
                  itemDashboard("shop".tr(), CupertinoIcons.shopping_cart,
                      Colors.brown, const ShopList()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(
          String title, IconData iconData, Color background, Widget name) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => name),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white)),
              const SizedBox(height: 8),
              Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      );
}
