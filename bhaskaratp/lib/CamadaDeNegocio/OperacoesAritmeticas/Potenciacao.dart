import 'dart:math';

import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';

class Soma implements CalculoDoisFatores{
  @override
  double CalculaDoisValores(double valorA, double valorB) {
    double? resultado;
    num representaValorA = num.parse(valorA.toString());
    num representaValorB = num.parse(valorB.toString());
    num representaResultado = num.parse(resultado.toString());

    representaResultado = pow(representaValorA, representaValorB);

    resultado = double.parse(representaResultado.toString());

    return resultado;
  }

}