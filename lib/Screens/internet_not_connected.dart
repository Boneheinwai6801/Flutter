import 'package:flutter/material.dart';

class InternetNotAvailable extends StatelessWidget {
  const InternetNotAvailable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: const Color.fromARGB(255, 27, 152, 184),
      ),
      child: const Center(
        child: Text(
          'No Internet Connection!!!',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
