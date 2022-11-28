import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';

class Divisao implements CalculoDoisFatores{
  @override
  double CalculaDoisValores(double valorA, double valorB) {
    double resultado;
    resultado = valorA/valorB;
    return resultado;
  }
}