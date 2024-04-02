import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Screens/loginScreen.dart';
import 'package:flutter_application_1/models/countryModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CountryAdapter());

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('my', 'MM')],
    path: "assets/language",
    fallbackLocale: const Locale('en', 'US'),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          initialData: InternetConnectionStatus.connected,
          create: (_) {
            return InternetConnectionChecker().onStatusChange;
          },
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(0.9)),
              child: child!);
        },
        home: const LoginScreen(),
      ),
    );
  }
}
