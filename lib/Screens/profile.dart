// ignore_for_file: must_be_immutable, prefer_final_fields, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/loginScreen.dart';
import 'package:flutter_application_1/Screens/shopDetailScreen.dart';
import 'package:flutter_application_1/data/preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class ProfileScreen extends StatefulWidget {
  GoogleSignInAccount? _currentUser;

  ProfileScreen(this._currentUser, {super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile".tr()),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            widget._currentUser!.photoUrl.toString())),
                  ),
                  Text(
                    widget._currentUser!.displayName.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                  Text(
                    widget._currentUser!.email.toString(),
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontStyle: FontStyle.normal),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.597,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartHistory()),
                    );
                  },
                  child: const Card(
                    child: ListTile(
                      title: Text('Checkout History'),
                      leading: Icon(Icons.payment),
                      trailing: Icon(Icons.chevron_right_outlined),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    showdialog(context);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text("lanuage".tr()),
                      leading: const Icon(Icons.language),
                      trailing: Text("lang".tr()),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      // title: const Text('AlertDialog Title'),
                      title: const Text('Are You Sure Want to Logout !'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // setState(() {
                            //   _googleSignIn.disconnect();
                            //   Preferences().saveStateInPref('0');
                            // });
                            _handleSignOut();
                            print('object is out');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const LoginScreen()),
                              ((route) => false),
                            );
                            // _googleSignIn.disconnect();
                            // Preferences().saveStateInPref('0');
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text("logout".tr()),
                      leading: const Icon(Icons.logout),
                      trailing: const Icon(Icons.chevron_right_outlined),
                    ),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}

showdialog(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => const AlertDialog(
      actions: [MyStatefulWidget()],
    ),
  );
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _group = 0;
  getState() async {
    _group = await Preferences().getStateLanguage();
  }

  @override
  void initState() {
    super.initState();
    // print('start');
    () async {
      await getState();
      setState(() {});
    }();
    // print('stop');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Text("clanuage".tr()),
        ),
        ListTile(
          title: const Text('English'),
          leading: Radio(
            value: 0,
            groupValue: _group,
            onChanged: (dynamic value) {
              setState(() {
                context.setLocale(const Locale("en", "US"));
                Preferences().saveStateLanguage(value);
                _group = value;
              });
              Navigator.pop(context);
            },
          ),
        ),
        ListTile(
          title: const Text('မြန်မာ'),
          leading: Radio(
            value: 1,
            groupValue: _group,
            onChanged: (dynamic value) {
              setState(() {
                context.setLocale(const Locale("my", "MM"));
                Preferences().saveStateLanguage(value);
                _group = value;
              });
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
