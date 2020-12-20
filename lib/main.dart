import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testination/homeScreen/homeScreen.dart';
import 'package:testination/provider/userEventsProvider.dart';
import 'package:testination/screens/mockeTest/QuestionsPage/qusetionAnswerProvider.dart';
import 'package:testination/screens/splashscreen.dart';
import 'package:testination/themeProvider.dart';

import 'provider/account.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Testination',
      theme: themeNotifier.getTheme(),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.green),
      initialRoute: SplashScreenWindow.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreenWindow.id: (context) => SplashScreenWindow(),
      },
    );
  }
}

//final FirebaseAuth _auth = FirebaseAuth.instance;
