// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:narinjara/screens/privacy_policy_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  String maplink;
  MapScreen(this.maplink, {Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

bool loading = true;

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    loading = true;
    log(widget.maplink);
  }

  final _key = UniqueKey();
  var loadingPercentage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Provider.of<InternetConnectionStatus>(context) ==
              InternetConnectionStatus.disconnected
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.signal_wifi_statusbar_connected_no_internet_4,
                    color: Colors.grey,
                    size: 90,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No Internet Connection Available !',
                    style: TextStyle(color: Color.fromARGB(255, 218, 138, 138)),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: WebView(
                    zoomEnabled: false,
                    backgroundColor: Colors.white,
                    initialUrl: widget.maplink,
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (url) {
                      setState(() {
                        loadingPercentage = 0;
                      });
                    },
                    onProgress: (progress) {
                      setState(() {
                        loadingPercentage = progress;
                      });
                    },
                    onPageFinished: (url) {
                      setState(() {
                        loadingPercentage = 100;
                      });
                    },
                  ),
                ),
                if (loadingPercentage < 100)
                  LinearProgressIndicator(
                    color: Colors.grey,
                    backgroundColor: Colors.blue,
                    value: loadingPercentage / 100.0,
                  ),
              ],
            ),
    );
  }
}
