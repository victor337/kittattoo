import 'package:advanced_splashscreen/advanced_splashscreen.dart';
import 'package:flutter/material.dart';
//import 'package:kittattoonovo/dentrodoapp/homepage.dart';
import 'package:kittattoonovo/scoped/scoped.dart';
import 'package:kittattoonovo/telasiniciais/login.dart';
import 'package:scoped_model/scoped_model.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        return Stack(
          children: <Widget>[
            Container(color: Color.fromARGB(255, 70, 0, 70)),
            AdvancedSplashScreen(
              child: LoginScreen(),
              seconds: 5,
              colorList: [
                Color.fromARGB(255, 70, 0, 70),
                Color.fromARGB(230, 70, 0, 70),
                Color.fromARGB(205, 70, 0, 70),
                Color.fromARGB(180, 70, 0, 70),
                Color.fromARGB(150, 70, 0, 70),
              ],
              appIcon: 'assets/logo.png',
              appTitle: '',
            )
          ],
        );
      },
    );
  }

  
}