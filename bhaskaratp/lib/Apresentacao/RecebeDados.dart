import 'package:flutter/material.dart';
import 'package:bhaskaratp/CamadaDeNegocio/calculodoisfatoresImpl.dart';
import 'package:bhaskaratp/CamadaDeNegocio/ChamaCalculosFacade/ChamaCalculosFacade.dart';
import '../CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';
import '../CamadaDeNegocio/OperacoesCompostas/Delta.dart';
import 'package:bhaskaratp/CamadaDeNegocio/ValidaDadosStrategy/ValidaDadosStrategy.dart';

class RecebeDadosBhaskara extends StatefulWidget {
  const RecebeDadosBhaskara({Key? key}) : super(key: key);



  @override
  State<RecebeDadosBhaskara> createState() => _RecebeDadosBhaskaraState();
}

class _RecebeDadosBhaskaraState extends State<RecebeDadosBhaskara> {

  final TextEditingController  valorXController = TextEditingController();
  final TextEditingController  valorXAController = TextEditingController();
  final TextEditingController  valorXBController = TextEditingController();

  CalculaDelta delta = CalculaDelta();
  validaDadosStrategy validaDados =  validaDadosStrategy();
  ChamaCalculosFacadePositivo chamaCalculosFacade =  ChamaCalculosFacadePositivo();
  double? resultadoPositivo;
  double? resultadoNegativo;
  double? resultadoDaraiz;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
                labelText: 'X2',
                border: OutlineInputBorder()
            ),
            controller: valorXAController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          TextField(
              decoration: InputDecoration(
                  labelText: 'X1',
                  border: OutlineInputBorder()
              ),
              controller: valorXBController,
              keyboardType: TextInputType.number
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
                labelText: 'X',
                border: OutlineInputBorder()
            ),
            keyboardType: TextInputType.number,
            controller: valorXController,
          ),
          TextButton(
            child: Text('calcular'),
            onPressed: () async {
              print('Controller A = ' + valorXAController.text);
              print('Controller B = ' + valorXBController.text);
              print('Controller C = ' + valorXController.text);
              setState((){
                resultadoDaraiz = delta.CalculandoDelta(
                    valorX2: double.tryParse(valorXAController.text),
                    valorX1: double.tryParse(valorXBController.text),
                    valorX: double.tryParse(valorXController.text));
                print(resultadoDaraiz);
                resultadoPositivo =validaDados.AcionaBhaskara(
                    'cp',
                    double.tryParse(valorXAController.text),
                    double.tryParse(valorXBController.text),
                    resultadoDaraiz);
                resultadoNegativo =validaDados.AcionaBhaskara(
                    'cn',
                    double.tryParse(valorXAController.text),
                    double.tryParse(valorXBController.text),
                    resultadoDaraiz);
              });

            },
          ),
          Text('O resultado da raiz: $resultadoDaraiz'),
          Text('O resultado 1 da Bhaskara: $resultadoPositivo'),
          Text('O resultado 2 da Bhaskara $resultadoNegativo')
        ],
      ),
    );
  }
}


