import 'package:flutter/material.dart';
import 'package:bhaskaratp/CamadaDeNegocio/calculodoisfatoresImpl.dart';

import '../CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';
import '../CamadaDeNegocio/OperacoesCompostas/Delta.dart';

class RecebeDadosBhaskara extends StatelessWidget {
   RecebeDadosBhaskara({Key? key}) : super(key: key);

  final TextEditingController  valorXController = TextEditingController();
  final TextEditingController  valorXAController = TextEditingController();
  final TextEditingController  valorXBController = TextEditingController();
  
  CalculaDelta delta = CalculaDelta();
  double? resultado;

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
                resultado = delta.CalculandoDelta(
                    valorX2: double.tryParse(valorXAController.text),
                    valorX1: double.tryParse(valorXBController.text),
                    valorX: double.tryParse(valorXController.text));
                print(resultado);

            },
          ),
      ],
      ),
    );
  }
}

