// ignore_for_file: deprecated_member_use, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/mapview.dart';
import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../models/countryModel.dart';

// ignore: must_be_immutable
class CountryDetail extends StatefulWidget {
  final Country country;
  const CountryDetail(this.country, {super.key});

  @override
  State<CountryDetail> createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  String formatpopulation(int population) {
    NumberFormat formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(population);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48),
                  // Image radius
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    // width: 30,
                    // height: 20,
                    imageUrl: widget.country.flag,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  // child: Image.network(widget.country.flag, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Text(
            widget.country.nname,
            style: const TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Region',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                Text(
                                  widget.country.region,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                      Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Capital',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                Text(
                                  widget.country.capital,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                      Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Population',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                Text(
                                  formatpopulation(widget.country.pop),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                      Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Currencies',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 100,
                                ),
                                Expanded(
                                  child: Text(
                                    '${widget.country.currencyName} (${widget.country.currencySymbol}) ',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Independent Country ?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                Text(
                                  widget.country.indep.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                      Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Language',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                Text(
                                  widget.country.languages.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MapScreen(widget.country.map.toString())),
                  );

                  // launchUrl(Uri.parse(widget.country.map),
                  //     mode: LaunchMode.inAppWebView);
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('View in Map'),
                        Icon(Icons.location_pin),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
