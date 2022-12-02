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
            controller: valorXAController,
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: valorXBController,
              keyboardType: TextInputType.number
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: valorXController,
          ),
          TextButton(
            child: Text('calcular'),

            onPressed: (){
              String controllerX = valorXBController.text;

              print('Controller A = ' + valorXAController.text);
              print('Controller B = ' + valorXBController.text);
              print('Controller C = ' + valorXController.text);
              resultado = delta.CalculandoDelta(valorX1: double.tryParse(valorXBController.text));
              print(resultado);
            },
          ),
      Text('$resultado'),
      ],
      ),
    );
  }
}

