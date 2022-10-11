import 'dart:math';
import 'package:bhaskara_revisao/Calculos/DELTA.dart';
import 'package:bhaskara_revisao/SOLID_interface/CALCULOBASE.dart';

import '../CalculosImpl.dart';

class CalculaBhakaraNegativa implements Calculobase{

  String? Acumulador;
  double? MultiplicadorDivisao = 2;

  CalculoImpl calculoDelta = CalculoImpl(CalculaDelta());

  @override
  String? CalculoDoisFatores({String? valorA, String? valorB, String? valorC}) {
    String? delta = calculoDelta.calculobase!.CalculoDoisFatores(
        valorA: valorA,
        valorB: valorB,
        valorC: valorC);
    double? Xa = double.parse(valorA!);
    double? Xb = double.parse(valorB!);
    double? Xc = double.parse(valorC!);
    double? Delta = double.parse(delta!);
    Xc = sqrt(Delta);
    Xa = (MultiplicadorDivisao! * Xa);
    double? acumulador;
    Xb = (-(Xb)-Xc);
    acumulador = (Xb/Xa);
    Acumulador = acumulador.toString();
    return Acumulador;
  }

  }




