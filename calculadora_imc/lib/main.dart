import 'package:flutter/material.dart';
import 'package:calculadora_imc/Functions/CalcIMC.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController alturaController = TextEditingController();
  final TextEditingController pesaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Infrome seus dados!';
  String IMC = ' ';
  CalculoIMC calculo = CalculoIMC();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC",),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed:(){
                setState((){
                  _infoText = 'Infrome seus dados!';
                  alturaController.clear();
                  pesaController.clear();
                  errorText = null;
                });
              },
              icon: Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.deepPurple.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.person, size: 150, color: Colors.deepPurple.shade300, ),
            //Campo Peso
              TextField(keyboardType: TextInputType.number,
              decoration:  InputDecoration(

                labelText:'Peso em KG',
                labelStyle: TextStyle(
                  color: Colors.deepPurple,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurple, fontSize: 25,),
              controller: pesaController,
            ),
            SizedBox(height: 10,),
           //Campo Altura
            TextField(keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                errorText: errorText,
                labelText:'Altura em Metros',
                labelStyle: TextStyle(
                  color: Colors.deepPurple,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurple, fontSize: 25,),
             controller: alturaController,
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                        if(alturaController.text.isEmpty || pesaController.text.isEmpty){
                          setState((){
                            errorText = 'Os campos acima estão vazios';
                            return;
                          });
                        }else{
                          IMC = calculo.calcimc(altura: alturaController.text, peso: pesaController.text);
                          setState((){
                            _infoText = IMC;
                            errorText = null;
                          });
                        }
                    },
                child: Text('Calcular', style: TextStyle(fontSize: 20)),
               style: ElevatedButton.styleFrom(
                 primary: Colors.deepPurple,
               ),
              ),
            ),
            SizedBox(height: 35,),
            Text('$_infoText',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurple, fontSize: 25,),
            ),
          ],
        ),
      ),
    );
  }
}
