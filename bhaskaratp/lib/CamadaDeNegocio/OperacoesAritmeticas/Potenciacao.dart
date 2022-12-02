import 'dart:math';

import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';

class Potenciacao {
  double? CalculaPotenciacao({double? valorA}) {
    print('INICIA POTENCIACAO');
    double? resultado = 0;
    print('$valorA');
    resultado = valorA! * valorA!;
    print('fim $resultado');
    return resultado;
  }

}