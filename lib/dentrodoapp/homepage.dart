import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height / 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Icon(Icons.shopping_cart),
                            ),
                            SizedBox(height: 5,),
                            Text("Carrinho")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Icon(Icons.person),
                            ),
                            SizedBox(height: 5,),
                            Text("Perfil")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Icon(Icons.confirmation_number),
                            ),
                            SizedBox(height: 5,),
                            Text("Cupons")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Novidades", style: TextStyle(fontSize: MediaQuery.of(context).size.height /25),)
                  ],
                ),
                Card(
                  elevation: 5,
                  color: Color.fromARGB(255, 70, 0, 70),
                  child: Container(
                    height:  MediaQuery.of(context).size.height * 0.2,
                    width:MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(3),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Aqui vai a primeira noticia")
                      ],
                    ),
                    ),
                ),
                SizedBox(height: 20,),
                Card(
                  elevation: 5,
                  color: Color.fromARGB(255, 70, 0, 70),
                  child: Container(
                    height:  MediaQuery.of(context).size.height * 0.2,
                    margin: EdgeInsets.all(3),
                    color: Colors.white,
                    ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}