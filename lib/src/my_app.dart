import 'package:flutter/material.dart';
import 'package:masterclass_notification/src/home/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Masterclass Notification",
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
      },
    );
  }
}
