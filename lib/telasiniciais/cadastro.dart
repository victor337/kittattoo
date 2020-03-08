import 'package:flutter/material.dart';
import 'package:kittattoonovo/scoped/scoped.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_correios/flutter_correios.dart';
import 'package:flutter_correios/model/resultado_cep.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';





class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final FocusNode fnOne = FocusNode();
  final FocusNode fnTwo = FocusNode();
  final FocusNode fnTree = FocusNode();
  final FocusNode fnFor = FocusNode();
  final FocusNode fnFive = FocusNode();
  final FocusNode fnSix = FocusNode();

  final FlutterCorreios fc = FlutterCorreios();

  var maskFormattercep = new MaskTextInputFormatter(mask: '########', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatternascimento = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  var maskFormattertelefone = new MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });

  TextEditingController nomecontroller = TextEditingController();
  TextEditingController idadecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController senhacontroller = TextEditingController();
  TextEditingController cepcontroller = TextEditingController();
  TextEditingController telcontroller = TextEditingController();

  int idade;
  bool aniversario = false;
  bool validacao = false;

  var hoje = int.parse(DateFormat('yyyy').format(DateTime.now()));

  String mostrarSenha = "Exibir senha";
  bool senha = true;
  Color corSenha = Colors.red;


  String endereco = "";


 

  //Função para caso conta seja criado com sucesso
          /*sucesso(){
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("deu", style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 2),
              )
            );
            Future.delayed(Duration(seconds: 2)).then((_){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            });
          }

          //Função para caso conta não seja criada
          falha(String problema){
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("$problema", style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 2),
              )
            );
          }
*/
  //Função para calcular idade
  calcularIdade(nasci){
    String primeiro = idadecontroller.text[6];
    String segundo = idadecontroller.text[7];
    String terceiro = idadecontroller.text[8];
    String quarto = idadecontroller.text[9];

    nasci = int.parse('${primeiro+segundo+terceiro+quarto}');
    setState(() {
      idade = hoje - nasci;
    });
  }

  //Função para buscar Cep
  buscarCep(String cep)async{
    ResultadoCEP resultado = await fc.consultarCEP(cep: cep);
    if(resultado == null){
      setState(() {
        endereco = "Endereço não encontrado!";
      });
    }
    else{
      setState(() {
        endereco = "${resultado.logradouro} - ${resultado.bairro}, ${resultado.estado}";
      });
    }
  }

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
      nomecontroller.text = "";
      idadecontroller.text = "";
      cepcontroller.text = "";
      endereco = "";
      _formkey = GlobalKey<FormState>();
    });
  }
  

  @override
  Widget build(BuildContext context) {

    

    naoPodeUsar(){
      showModalBottomSheet(
        context: context,
        builder: (_){
          return Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Você precisa ser maior de 16 anos!", style: TextStyle(fontSize: 22),),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.purple,
                        onPressed: (){
                          Navigator.pop(context);                          
                        },
                        child: Text("Entendi!", style: TextStyle(color: Colors.white,)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
        );
    }



    //Função para validacao
    validarfalse(){
      showDialog(
        context: context,
        child: AlertDialog(
          content: Text("Você precisa confirmar os dados!", textAlign: TextAlign.center, style: TextStyle(fontSize: 22),),  
          actions: <Widget>[
            RaisedButton(
                        color: Colors.red,
                        onPressed: (){
                          Navigator.pop(context);                          
                        },
                        child: Text("Cancelar!", style: TextStyle(color: Colors.white,)),
                      ),
                    RaisedButton(
                        color: Colors.blue,
                        onPressed: (){
                          setState(() {
                            validacao = true;
                          });
                          Navigator.pop(context);                         
                        },
                        child: Text("Confirmo!", style: TextStyle(color: Colors.white,)),
                      ),
          ],
        )
        );
    }


    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model){
        if(model.carregando == true){
          return Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(color: Color.fromARGB(255, 70, 0, 70)),
                  Center(child: Text("Cadastrando\nAguarde",
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 25,),))
                ],
              ),
            ),
          );
        }
        else{       

          
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromARGB(255, 70, 0, 70),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Cadastro", style: TextStyle(fontSize: 22),),
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
                            SizedBox(height: 10,),
                            Row(
                              children: <Widget>[                          
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Nome', style: TextStyle(color: Colors.white, fontSize: 18),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: TextFormField(
                                            controller: nomecontroller,
                                            textInputAction: TextInputAction.next,
                                            focusNode: fnOne,
                                            validator: (texto){
                                              if(texto.isEmpty){
                                                return "Prencha!";
                                              } return null;
                                            },
                                            onFieldSubmitted: (form){
                                              fnOne.unfocus();
                                              FocusScope.of(context).requestFocus(fnTwo);
                                            },
                                            autocorrect: false,
                                            decoration: InputDecoration(
                                              border: InputBorder.none
                                            ),
                                            style: TextStyle(
                                              color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  )
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Nascimento', style: TextStyle(color: Colors.white, fontSize: 18),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: TextFormField(
                                            inputFormatters: [maskFormatternascimento],
                                            controller: idadecontroller,
                                            textInputAction: TextInputAction.next,
                                            focusNode: fnTwo,
                                            onFieldSubmitted: (form){
                                              fnTwo.unfocus();
                                              FocusScope.of(context).requestFocus(fnTree);
                                              calcularIdade(form);
                                            },
                                            keyboardType: TextInputType.number,
                                            autocorrect: false,
                                            validator: (texto){
                                              if(texto.isEmpty){
                                                return "Preencha!";
                                              }
                                              if(texto.length < 10){
                                                return "Formato inválido";
                                              }                                        
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none
                                            ),
                                            style: TextStyle(
                                              color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  )
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Cep', style: TextStyle(color: Colors.white, fontSize: 18),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          inputFormatters: [maskFormattercep],
                                          controller: cepcontroller,
                                          textInputAction: TextInputAction.next,
                                          focusNode: fnTree,
                                          onFieldSubmitted: (form){
                                            fnTree.unfocus();
                                            FocusScope.of(context).requestFocus(fnFor);
                                            buscarCep(form);
                                          },
                                          keyboardType: TextInputType.number,
                                          autocorrect: false,
                                          validator: (texto){
                                            if(texto.isEmpty){
                                              return "Preencha!";
                                            }
                                            if(texto.length < 8 ){
                                              return "Formato inválido";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none
                                          ),
                                          style: TextStyle(
                                            color: Colors.black
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Telefone', style: TextStyle(color: Colors.white, fontSize: 18),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: TextFormField(
                                            inputFormatters: [maskFormattertelefone],
                                            controller: telcontroller,
                                            textInputAction: TextInputAction.next,
                                            focusNode: fnFor,
                                            onFieldSubmitted: (form){
                                              fnFor.unfocus();
                                              FocusScope.of(context).requestFocus(fnFive);
                                              calcularIdade(form);
                                            },
                                            keyboardType: TextInputType.number,
                                            autocorrect: false,
                                            validator: (texto){
                                              if(texto.isEmpty){
                                                return "Preencha!";
                                              }
                                              if(texto.length != 15){
                                                return "Formato inválido";
                                              }                                        
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none
                                            ),
                                            style: TextStyle(
                                              color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  )
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(endereco, style: TextStyle(color: Colors.white,))
                              ],
                            ),
                            SizedBox(height: 5,),
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
                                focusNode: fnFive,
                                onFieldSubmitted: (form){
                                  fnFive.unfocus();
                                  FocusScope.of(context).requestFocus(fnSix);
                                },
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                validator: (texto){
                                  if(texto.isEmpty){
                                    return "Preencha!";
                                  }
                                  if(!texto.contains("@")){
                                    return "Insira um email válido";
                                  }
                                  return null;
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
                                focusNode: fnSix,
                                keyboardType: TextInputType.visiblePassword,
                                autocorrect: false,
                                validator: (texto){
                                  if(texto.isEmpty){
                                    return "Preencha!";
                                  }
                                  if(texto.length < 6){
                                    return "Mínimo de 6 caracteres";
                                  } 
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none
                                ),
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              ),
                            ),
                            SizedBox(height: 10),                            
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
                            Card(
                              child: Column(
                                children: <Widget>[
                                   Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: aniversario,
                                        activeColor: Colors.purple,
                                        onChanged: (bool resposta){
                                          setState(() {
                                            aniversario = resposta;
                                          });
                                        }
                                      ),
                                      Text('Fiz aniversário este ano'),                                      
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: validacao,
                                        activeColor: Colors.purple,
                                        onChanged: (bool resposta){
                                          setState(() {
                                            validacao = resposta;
                                          });
                                        }
                                      ),
                                      Text('Confirmo que os dados acima são verdadeiros'),                                      
                                    ],
                                  ),
                                ],
                              ),
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
                                    if(idade < 16){
                                      naoPodeUsar();
                                    }
                                    else{
                                      if(validacao == false){
                                        validarfalse();
                                      }
                                      else{
                                        if(aniversario == false){
                                          setState(() {
                                            idade -= 1;
                                          });                                        
                                          Map<String, dynamic> userData = {
                                            "Nome": nomecontroller.text,
                                            "Idade": idade,
                                            "Email": emailcontroller.text,
                                            "Endereço": cepcontroller.text,
                                            "Data de nascimento": idadecontroller.text,
                                            "Contato": telcontroller.text
                                          };
                                          model.criarConta(
                                            userData,
                                            senhacontroller.text,
                                            _scaffoldKey,
                                            context
                                          );
                                          resetarCampos();
                                        }
                                        else{
                                          Map<String, dynamic> userData = {
                                            "Nome": nomecontroller.text,
                                            "Idade": idade,
                                            "Email": emailcontroller.text,
                                            "Endereço": cepcontroller.text,
                                            "Data de nascimento": idadecontroller.text,
                                            "Contato": telcontroller.text
                                          };
                                          model.criarConta(
                                            userData,
                                            senhacontroller.text,
                                            _scaffoldKey,
                                            context
                                          );
                                          resetarCampos();
                                        }
                                      }
                                      
                                      
                                    }
                                  }
                                },
                                child: Text("Criar conta", style: TextStyle(fontSize: 18),),
                                ),
                            ),
                            SizedBox(height: 10,),                            
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
          
        }    
            
      },
    );
    
  }

  
}
