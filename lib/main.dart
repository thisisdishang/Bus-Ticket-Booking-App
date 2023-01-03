import 'package:bus_ticket_booking_app/pages/loginpage.dart';
import 'package:bus_ticket_booking_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lighttheme(context),
      darkTheme: MyTheme.darktheme(context),
      home: LoginPage(),
      /*  initialRoute: "login",
      routes: {
        "/": (context) => LoginPage(),
      //  "home": (context) => HomePage(),
        "login": (context) => LoginPage(),
        "signup": (context) => SignupPage(),
      },*/
    );
  }
}
