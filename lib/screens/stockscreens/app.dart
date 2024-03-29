import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:panja/screens/stockscreens/theme_provider.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'homepage.dart';
import 'provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AppProvider>(builder:
          (BuildContext context, AppProvider appProvider, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme: themeData(
            appProvider.dark ? Constants.darkTheme : Constants.lightTheme,
          ),
          home: const Home(),
        );
      }),
    );
  }
}

// Apply font to our app's theme
ThemeData themeData(ThemeData theme) {
  return theme.copyWith(
    textTheme: GoogleFonts.nunitoTextTheme(
      theme.textTheme,
    ),
  );
}
