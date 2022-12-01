import 'package:flutter/material.dart';
import 'package:bhaskaratp/CamadaDeNegocio/calculodoisfatoresImpl.dart';

import '../CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';

class RecebeDadosBhaskara extends StatelessWidget {
   RecebeDadosBhaskara({Key? key}) : super(key: key);

  final TextEditingController  valorXController = TextEditingController();
  final TextEditingController  valorXAController = TextEditingController();
  final TextEditingController  valorXBController = TextEditingController();
  CalculoDoisFatoresImpl calculoDoisFatoresImpl = CalculoDoisFatoresImpl(calculodoisfatores: Radiciacao());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: valorXAController,
          ),
          TextField(
            controller: valorXBController,
          ),
          TextField(
            controller: valorXController,
          ),
          TextButton(
            child: Text('calcular'),
            onPressed: (){

            },
          ),
        ],
      ),
    );
  }
}

