import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testination/provider/userEventsProvider.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/qusetionAnswerProvider.dart';
import 'package:testination/screens/splashscreen.dart';
import 'package:testination/themeProvider.dart';

import 'provider/account.dart';
import 'screens/homeScreen/home.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<QuestionAnswersProvider>(
        create: (context) => QuestionAnswersProvider(),
      ),
      ChangeNotifierProvider<ThemeNotifier>(
        create: (context) => ThemeNotifier(),
      ),
      ChangeNotifierProvider<MyAccount>(
        create: (context) => MyAccount(),
      ),
      ChangeNotifierProvider<UserEventsProvider>(
        create: (context) => UserEventsProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool isDark = themeNotifier.isDark();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: isDark == false ? Colors.white : Color(0xff212121),
        statusBarIconBrightness:
            isDark == false ? Brightness.dark : Brightness.light));
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: darkModeOn == false ? Colors.white : Color(0xff212121),
        statusBarIconBrightness:
            darkModeOn == false ? Brightness.dark : Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testination',
      theme: themeNotifier.getTheme(),
      // darkTheme: darkTheme,
      initialRoute: SplashScreenWindow.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreenWindow.id: (context) => SplashScreenWindow(),
      },
    );
  }
}

//final FirebaseAuth _auth = FirebaseAuth.instance;

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  primaryColorLight: Colors.white24,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  primaryColorDark: Colors.white,
  buttonColor: Color(0xff49c6e6),
);
