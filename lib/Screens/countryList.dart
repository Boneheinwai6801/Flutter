// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/countryDetail.dart';
import 'package:flutter_application_1/Screens/internet_not_connected.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/countryModel.dart';
import '../apis/countryApi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CountryList extends StatelessWidget {
  const CountryList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country List'),
      ),
      body: FutureBuilder<List<Country>>(
        future: CountryApi.getCountries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width -
                                          250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            )));
                  }),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Country>? countries = snapshot.data;

            return Stack(
              children: [
                ListView.builder(
                  itemCount: countries?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CountryDetail(countries![index])),
                        );
                      },
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          leading: CachedNetworkImage(
                            width: 40,
                            height: 40,
                            imageUrl: countries?[index].flag ?? '',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          title: Text(countries?[index].name ?? ''),
                          // leading: Image.network(
                          //   countries?[index].flag ?? '',
                          //   width: 30,
                          //   height: 20,
                          // ),

                          subtitle: Text(countries?[index].region ?? ''),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                    top: 0,
                    child: Visibility(
                        visible:
                            Provider.of<InternetConnectionStatus>(context) ==
                                InternetConnectionStatus.disconnected,
                        child: const InternetNotAvailable())),
              ],
            );
          }
        },
      ),
    );
  }
}
