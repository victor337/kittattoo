import 'package:flutter/material.dart';
import 'package:kittattoonovo/dentrodoapp/homepage.dart';
import 'package:kittattoonovo/scoped/scoped.dart';
import 'package:kittattoonovo/telasiniciais/cadastro.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode fnOne = FocusNode();
  final FocusNode fnTwo = FocusNode();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController senhacontroller = TextEditingController();

  String mostrarSenha = "Exibir senha";
  bool senha = true;
  Color corSenha = Colors.red;

  //Função para botão que exibe senha no textformfield
  exibirSenha(){
    setState(() {
      if(mostrarSenha == "Exibir senha"){
        mostrarSenha = "Ocultar senha";
        senha = false;
        corSenha = Colors.blue;
      }
      else{
        mostrarSenha = "Exibir senha";
        senha = true;
        corSenha = Colors.red;
      }
    });
  }

  //Função para resetar os textsformsfields
  resetarCampos(){
    setState(() {
      emailcontroller.text = "";
      senhacontroller.text = "";
      _formkey = GlobalKey<FormState>();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        if(model.carregando == true){
          return Scaffold(
            key: _scaffoldKey,
            body: Stack(
              children: <Widget>[
                Container(color: Color.fromARGB(255, 70, 0, 70)),
                Center(child: Text("Cadastrando\nAguarde",
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 25,),))
              ],
            ),
          );
        }
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 70, 0, 70),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Login", style: TextStyle(fontSize: 22),),
                ],
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(color: Color.fromARGB(255, 70, 0, 70),),
                SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Image.asset("assets/logo.png", fit: BoxFit.contain,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Email', style: TextStyle(color: Colors.white, fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: emailcontroller,
                              textInputAction: TextInputAction.next,
                              focusNode: fnOne,
                              onFieldSubmitted: (form){
                                fnOne.unfocus();
                                FocusScope.of(context).requestFocus(fnTwo);
                                FocusScope.of(context).dispose();
                              },
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (texto){
                                if(!texto.contains("@")){
                                  return "Insira um email válido";
                                } return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Senha', style: TextStyle(color: Colors.white, fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: senhacontroller,
                              obscureText: senha,
                              focusNode: fnTwo,
                              keyboardType: TextInputType.visiblePassword,
                              autocorrect: false,
                              validator: (texto){
                                if(texto.length < 6){
                                  return "Mínimo de 6 caracteres";
                                } return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                color: corSenha,
                                onPressed: exibirSenha,
                                child: Text(mostrarSenha, style: TextStyle(color: Colors.white),)
                                )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: FlatButton(
                              textColor: Colors.blue,
                              onPressed: (){
                                if(_formkey.currentState.validate()){   
                                  model.entrarConta(emailcontroller.text, senhacontroller.text, _scaffoldKey, context);
                                  resetarCampos();
                                }
                              },
                              child: Text("Entrar", style: TextStyle(fontSize: 18),),
                              ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                color: Colors. black,
                                borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              Text("Ou", style: TextStyle(color: Colors.white, fontSize: 15),),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                color: Colors. black,
                                borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.pink),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: FlatButton(
                              textColor: Colors.pink,
                              onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => CadastroScreen())
                                );
                              },
                              child: Text("Ainda não tenho uma conta", style: TextStyle(fontSize: 18),),
                              ),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //Função para caso conta seja criado com sucesso
  sucesso(){
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  //Função para caso conta não seja criada
  falha(){
    showDialog(context: context,
    child: AlertDialog(content: Text("teste"),)
    );
  }
}