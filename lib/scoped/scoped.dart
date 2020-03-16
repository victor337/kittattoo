import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kittattoonovo/dentrodoapp/homepage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class UserModel extends Model {

  

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  
  bool carregando = false;

  String erros;
  String erross;

  //Função para mostrar snackbar caso seja criado com sucesso
    criado(dynamic scaffoldKey, BuildContext context){
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Conta criada com sucesso!'), duration: Duration(seconds: 3), backgroundColor: Colors.blue,)
      );
      Future.delayed(Duration(seconds: 3)).then((_){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()), ModalRoute.withName('HomePage')
        );
      });
    }

    //Função para mostrar snackbar caso não seja criado
    naoCriado(dynamic scaffoldKey, var erro){
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Conta não criada: $erro'), duration: Duration(seconds: 3), backgroundColor: Colors.red,)
      );
    }

  //Função para mostrar snackbar caso seja criado com sucesso
    logado(dynamic scaffoldKey, BuildContext context){
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Logado com suscesso!'), duration: Duration(seconds: 3), backgroundColor: Colors.purpleAccent,)
      );
      Future.delayed(Duration(seconds: 3)).then((_){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()), ModalRoute.withName('HomePage')
        );
      });
    }

    //Função para mostrar snackbar caso não seja criado
    naoLogado(dynamic scaffoldKey, var erro){
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Não logado: $erro'), duration: Duration(seconds: 3), backgroundColor: Colors.red,)
      );
    }

  pegarUidDoUsuario()async{
    await FirebaseAuth.instance.currentUser().then((user){

      firebaseUser = user;
      notifyListeners();

    }).catchError((erro){
      firebaseUser = null;
      notifyListeners();
    });
  }

  void criarConta(Map<String, dynamic> userData, String pass, dynamic scaffoldKey, BuildContext context){

    
    
    carregando = true;
    notifyListeners();
    

    FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: userData["Email"],
    password: pass).then((auth)async{

      
    
      firebaseUser = auth.user;

      await saveUserData(userData);

      criado(scaffoldKey, context);
      carregando = false;
      notifyListeners();

    }).catchError((erro)async{

      
      erros = await erro.code;
      if(erros.toString() == "ERROR_EMAIL_ALREADY_IN_USE"){
        erros = "Email em uso!";
      }
      else if(erros.toString() == "ERROR_INVALID_EMAIL"){
        erros = "O email não parece ser um email válido";
      }
      else{
        erros = "Um erro desconhecido aconteceu";
      }

      notifyListeners();
      print("aaaaaaa $erros");

      naoCriado(scaffoldKey ,erros);
      carregando = false;
      notifyListeners();



    });
  }
  
  void sairConta()async{
    await FirebaseAuth.instance.signOut();
    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void entrarConta(String email, String pass, dynamic scaffoldKey, BuildContext context){

    carregando = true;
    notifyListeners();
    
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).then((auth){
      firebaseUser = auth.user;
      logado(scaffoldKey, context);
      carregando = false;
      notifyListeners();
    }).catchError((erro)async{

      erross = await erro.code;
      if(erross.toString() == "ERROR_WRONG_PASSWORD"){
        erross = "Senha incorreta!";
      }
      else if(erross.toString() == "ERROR_INVALID_EMAIL"){
        erross = "O email não parece ser um email válido.";
      }
      else if(erross.toString() == "ERROR_USER_NOT_FOUND"){
        erross = "O usuário não existe.";
      }
      else if(erross.toString() == "ERROR_USER_DISABLED"){
        erross = "Este usuário foi desabilitado.";
      }
      else if(erross.toString() == "ERROR_TOO_MANY_REQUESTS"){
        erross = "Muitas requisições. Tente mais tarde.";
      }
      else{
        erross = "Um erro desconhecido aconteceu";
      }
      notifyListeners();

      naoLogado(scaffoldKey, erross);
      carregando = false;
      notifyListeners();
    });


  }

  void recuperarPass(String email){
    carregando = true;
    notifyListeners();
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    carregando = false;
    notifyListeners();
  }

  bool estaLogado(){
    return FirebaseAuth.instance.currentUser() != null;
  }
 
  Future<Null> saveUserData(Map<String, dynamic> userData)async{
    this.userData = userData;
    await Firestore.instance.collection("Usuarios").document(firebaseUser.uid).setData(userData);
  }

}