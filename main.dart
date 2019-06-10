import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController controlePeso = TextEditingController();
  TextEditingController controleAltura = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _info = 'Informe seus dados';
  var cor = Colors.black12;
  var corFundo = Colors.blueGrey;

  void _resetFields(){
    controlePeso.text = '';
    controleAltura.text ='';
    setState(() {
      _info = 'Informe seus dados';
      cor = Colors.black12;
      corFundo = Colors.blueGrey;
    });

  }

  void _calcula(){
    setState(() {
      double peso = double.parse(controlePeso.text);
      double altura = double.parse(controleAltura.text) / 100;
      double imc = peso / (altura * altura);

      if(imc < 18.6){
        _info = 'Abaixo do Peso (${imc.toStringAsPrecision(4)})';
        setState(() {
          cor = Colors.red;
          corFundo = Colors.red;
        });
      }
      else if(imc >= 18.6 && imc < 24.9){
        _info = 'Peso Ideal(${imc.toStringAsPrecision(4)})';
        setState(() {
          cor = Colors.lightGreen;
          corFundo = Colors.green;
        });
      }
      else if(imc >= 24.9 && imc < 29.9){
        _info = 'Levemente Acima do Peso (${imc.toStringAsPrecision(4)})';
        setState(() {
          cor = Colors.pink;
          corFundo = Colors.purple;
        });
      }
      else if(imc >= 29.9 && imc < 34.9){
        _info = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
        setState(() {
          cor = Colors.red;
          corFundo = Colors.red;
        });
      }
      else if(imc >= 34.9 && imc < 39.9){
        _info = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
        setState(() {
          cor = Colors.red;
          corFundo = Colors.red;
        });
      }
      else if(imc >= 40){
        _info = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
        setState(() {
          cor = Colors.red;
          corFundo = Colors.red;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: cor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),

      backgroundColor: corFundo,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.white),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.white)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
                controller: controlePeso,
                validator: (value){
                  if(value.isEmpty){
                    return 'Insira Seu Peso';
                  }
                },
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.white)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
                controller: controleAltura,
                validator: (value){
                  if(value.isEmpty){
                    return 'Insira Sua Altura';
                  }
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calcula();
                      }
                    },
                    child: Text('Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: cor,
                  ),
                ),
              ),

              Text('$_info',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
