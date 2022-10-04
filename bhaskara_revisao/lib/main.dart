import 'package:bhaskara_revisao/Calculos/BHASKARANEGATIVA.dart';
import 'package:bhaskara_revisao/Calculos/BHASKARAPOSITIVA.dart';
import 'package:bhaskara_revisao/Calculos/DELTA.dart';
import 'package:bhaskara_revisao/CalculosImpl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalculoImpl calculoImpl = new CalculoImpl(new CalculaDelta());
  final valorAController = TextEditingController();
  final valorBController = TextEditingController();
  final valorCController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bhaskara SOLID'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: valorAController,
              onChanged: (valor){
                print(valorAController.text);
              },
            ),
            TextField(
              controller: valorBController,
              onChanged: (valor){
                print(valorBController.text);
              },
            ),
            TextField(
              controller: valorCController,
             onChanged: (valor){
                print(valorCController.text);
             },
            ),
            TextButton(
                onPressed: (){
                  String? Delta = calculoImpl.calculobase?.CalculoDoisFatores(
                      valorA: valorAController.text,
                      valorB: valorBController.text,
                      valorC: valorCController.text);
                  print('Delta: $Delta');
                }, child: Text('Delta'),),
            SizedBox(height: 10,),
            TextButton(
              onPressed: (){
                calculoImpl.calculobase = new CalculaBhaskaraPositiva();
                String? BhaskaraPositiva = calculoImpl.calculobase?.CalculoDoisFatores(
                    valorA: valorAController.text,
                    valorB: valorBController.text,
                    valorC: valorCController.text
                );
                print('BhaskaraPositiva: $BhaskaraPositiva');
              },
              child: Text('Bhascara Positiva'),
            ),
            SizedBox(height: 10,),
           TextButton(
              onPressed: (){
                calculoImpl.calculobase = new CalculaBhakaraNegativa();
                String? BhaskaraNegativa = calculoImpl.calculobase?.CalculoDoisFatores(
                    valorA: valorAController.text,
                    valorB: valorBController.text,
                    valorC: valorCController.text
                );
                print('BhaskaraNegativa: $BhaskaraNegativa');
              },
              child: Text('Bhascara Negativa'),
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
