import 'dart:math';
import 'package:bhaskara_revisao/Calculos/DELTA.dart';
import 'package:bhaskara_revisao/SOLID_interface/CALCULOBASE.dart';

import '../CalculosImpl.dart';

class CalculaBhakaraNegativa implements Calculobase{

  //CalculaDelta calculaDelta = new CalculaDelta();

  String? Acumulador;
  double? MultiplicadorDivisao = 2;

  CalculoImpl calculoDelta = new CalculoImpl(new CalculaDelta());

  @override
  String? CalculoDoisFatores({String? valorA, String? valorB, String? valorC}) {
    double delta = calculoDelta.calculobase!.CalculoDoisFatores(
        valorA: valorA,
        valorB: valorB,
        valorC: valorC) as double;
    double? Xa = double.parse(valorA!);
    double? Xb = double.parse(valorA!);
    double? Xc = double.parse(valorA!);
    Xc = sqrt(delta);
    Xa = (MultiplicadorDivisao! * Xa)!;
    double? acumulador;
    Xb = (-(Xb)-Xc);
    acumulador = (Xb/Xa);
    Acumulador = acumulador.toString();
    return Acumulador;
  }

  }




