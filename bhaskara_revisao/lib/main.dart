import 'package:bhaskara_revisao/Calculos/DELTA.dart';
import 'package:bhaskara_revisao/CalculosImpl.dart';
import 'package:bhaskara_revisao/RegrasDeNeg%C3%B3cio/VALIDATIPODERESULTADO.dart';
import 'package:bhaskara_revisao/RegrasDeNeg%C3%B3cio/ValidaCampos.dart';
import 'package:bhaskara_revisao/ValidaCamposIMPL.dart';
import 'package:flutter/material.dart';
import 'Calculos/BHASKARANEGATIVA.dart';
import 'Calculos/BHASKARAPOSITIVA.dart';


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
  CalculoImpl calculoImpl = CalculoImpl(CalculaDelta());
  validaCampoIMPL validacampoimpl = validaCampoIMPL(validaValores());
  validaValores valores = validaValores();
  final valorAController = TextEditingController();
  final valorBController = TextEditingController();
  final valorCController = TextEditingController();
  late final String? BhaskaraPositiva;
  late final String? BhaskaraNegativa;
  late final String? Delta;
  late final String? TipoBhaskara;
  String? Status = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bhaskara SOLID'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              controller: valorAController,
              onChanged: (valor){
                Status = validacampoimpl.validadados!.validaCampo(campoA: valorAController.text);
                print(valorAController.text);
              },
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: valorBController,
              onChanged: (a){
                  Status = valores.validaCampo(campoB: valorBController.text);
                print(valorBController.text);
              },
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: valorCController,
             onChanged: (valor){
                Status = validacampoimpl.validadados!.validaCampo(campoC: valorCController.text);
               print(valorCController.text);
             },
            ),
            TextButton(
                onPressed: (){
                validacampoimpl.validadados = ClassficaBhaskara();
                String? TipoBhaskara = validacampoimpl.validadados?.validaCampo(
                      campoA: valorAController.text,
                      campoB: valorBController.text,
                      campoC: valorCController.text
                  );
                if(TipoBhaskara == 'Raiz negativa'|| Status == 'Digite Apenas Numeros'){
                  setState((){
                    Status = 'Digite numeros validos';
                  });
                }else{
                  String? Delta = calculoImpl.calculobase?.CalculoDoisFatores(
                      valorA: valorAController.text,
                      valorB: valorBController.text,
                      valorC: valorCController.text);
                  print('Delta: $Delta');
                  calculoImpl.calculobase = CalculaBhaskaraPositiva();
                  String? BhaskaraPositiva = calculoImpl.calculobase?.CalculoDoisFatores(
                      valorA: valorAController.text,
                      valorB: valorBController.text,
                      valorC: valorCController.text
                  );
                  print('BhaskaraPositiva: $BhaskaraPositiva');
                  calculoImpl.calculobase = CalculaBhakaraNegativa();
                 String? BhaskaraNegativa = calculoImpl.calculobase?.CalculoDoisFatores(
                      valorA: valorAController.text,
                      valorB: valorBController.text,
                      valorC: valorCController.text
                  );
                  setState((){
                    Status = ('Delta: $Delta, '
                        'Bhaskara Positiva: $BhaskaraPositiva, '
                        'Bhaskara Negativa: $BhaskaraNegativa');
                  });
                }
                }, child: const Text('Calcular Bhaskara'),),
            Text('Status: $Status'),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
