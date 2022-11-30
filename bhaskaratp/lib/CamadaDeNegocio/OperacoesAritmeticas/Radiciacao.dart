import 'dart:math';

import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';

class Radiciacao implements CalculoDoisFatores{
  @override
  double CalculaDoisValores({double? valorA, double? valorB}) {

    valorB = sqrt(valorA!);

    return valorB;
  }

}