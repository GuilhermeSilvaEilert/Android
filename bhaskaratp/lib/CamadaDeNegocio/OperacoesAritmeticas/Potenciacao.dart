import 'dart:math';

import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';

class Potenciacao {
  double? CalculaPotenciacao({double? valorA}) {
    double? resultado = 0;
    resultado = valorA! * valorA!;
    return resultado;
  }

}