import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kittattoonovo/scoped/scoped.dart';
import 'package:kittattoonovo/telasiniciais/splashscreen.dart';
//import 'package:kittattoonovo/telasiniciais/login.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'KitTattoo',
        theme: ThemeData(
          primaryColor: Colors.purple,
          fontFamily: 'Ubuntu',
          primarySwatch: Colors.grey,
        ),
        home: SplashScreen(),
      ),
    );
  }
}