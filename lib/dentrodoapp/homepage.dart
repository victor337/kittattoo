import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kittattoonovo/widgets/item_slide.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController;
  int _currentIndex;
  TextEditingController pesquisa = TextEditingController();

  funcao(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Teste())
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              //Background
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(230, 70, 0, 70),
              ),
              //Corpo
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.1, 0, 0),
                    child: SizedBox(
                      height: 200,
                      child: PageView(
                        physics: BouncingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                            });
                          },
                          children: <Widget>[
                          ItemSlide(
                            function: funcao,
                                  index: 0,
                                  cuttentIndex: _currentIndex,
                                  image: 'https://cdn.pixabay.com/photo/2017/08/03/13/01/people-2576110_960_720.jpg',
                                  title: "Tattoos",
                                  subtitle: "Cuidados com a tatuagem",
                                ),
                                ItemSlide(
                                  index: 1,
                                  cuttentIndex: _currentIndex,
                                  image: 'https://cdn.pixabay.com/photo/2015/11/07/11/26/hands-1031131__340.jpg',
                                  title: "Cupons de desconto",
                                  subtitle: "Conferir se há cupons de desconto",
                                ),
                                ItemSlide(
                                  index: 2,
                                  cuttentIndex: _currentIndex,
                                  image: 'https://cdn.pixabay.com/photo/2018/03/28/11/51/tattoo-3268988__340.jpg',
                                  title: "Locais",
                                  subtitle: "Locais para se tatuar",
                                ),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){},
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Icon(Icons.person, color: Colors.white,),
                              ),
                              SizedBox(height: 5,),
                              Text('Perfil', style: TextStyle(color: Colors.black),)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Icon(Icons.list, color: Colors.white,),
                              ),
                              SizedBox(height: 5,),
                              Text('Sessões', style: TextStyle(color: Colors.black),)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Icon(Icons.tag_faces, color: Colors.white,),
                              ),
                              SizedBox(height: 5,),
                              Text('Teste', style: TextStyle(color: Colors.black),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
              //Barra de pesquisa
              Container(
                margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10, // soften the shadow
                            spreadRadius: 0.1, //extend the shadow
                            offset: Offset(
                              5, // Move to right 10  horizontally
                              2, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          controller: pesquisa,
                          style: TextStyle(color: Colors.black),  
                          textInputAction: TextInputAction.go,                      
                          decoration: InputDecoration(
                            hintText: "Pesquise por algo",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: Colors.black,),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocaisBanco extends StatelessWidget {

  final DocumentSnapshot snapshot;
  LocaisBanco(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: Firestore.instance.collection("Locais").document(snapshot.documentID).get(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        else{
          return Container(
            color: Colors.purple,
            child: Text(snapshot.data["Nome"]),
          );
        }
      },
    );
  }
}

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}