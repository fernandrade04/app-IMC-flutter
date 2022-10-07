import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  @override
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields(){
    _formKey = GlobalKey<FormState>();
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100.0;

      double imc = weight / (height * height);

      if(imc < 18.6){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      }
      if(imc > 18.5 && imc < 25){
        _infoText = "Peso normal (${imc.toStringAsPrecision(4)})";
      }
      if(imc > 24.9 && imc < 30){
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
      }
      if(imc > 29.9 && imc < 35){
        _infoText = "Obesidade grau 1 (${imc.toStringAsPrecision(4)})";
      }
      if(imc > 34.9 && imc < 40){
        _infoText = "Obesidade grau 2 (${imc.toStringAsPrecision(4)})";
      }
      if(imc > 40){
        _infoText = "Obesidade grau 3 (${imc.toStringAsPrecision(4)})";
      }
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,

        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline, size: 120.0, color: Colors.green,),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Peso(kg)",
              labelStyle: TextStyle(color:
              Colors.green)

            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0),
            controller: weightController,
            validator: (value) {
              if (value!.isEmpty){
                return "Insira seu peso";
              }else if(double.parse(value) > 500) {
                return "Informe um peso menor que 500 kg!";
              }else if(double.parse(value) < 0){
                return "Informe um número positivo!";
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Altura(cm)",
              labelStyle: TextStyle(color:
              Colors.green)
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0),
            controller: heightController,
            validator: (value) {
              if (value!.isEmpty){
                return "Insira sua Altura";
              } else if(double.parse(value) > 300) {
                return "Informe uma altura menor que 3 metros!";
              }else if(double.parse(value) < 0){
                return "Informe um número positivo!";
              }
            },
          ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
            height: 50.0,
          child: ElevatedButton(
            onPressed: (){
              if(_formKey.currentState!.validate() )
                _calculate();
            },
            child: Text("Calcular",style: TextStyle(color: Colors.white, fontSize: 25.0),),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
          ),
            ),
            Text(
              "$_infoText", style: TextStyle(color: Colors.green, fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
        ],
      ),
        ),
      ),
    );
  }
}
