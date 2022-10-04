import 'dart:math';
import 'package:flutter/services.dart';
import 'package:bhaskara_revisao/SOLID_interface/CALCULOBASE.dart';

class CalculaDelta implements  Calculobase{

  String? Acumulador = "0";

  @override
  String? CalculoDoisFatores({String? valorA, String? valorB, String? valorC}) {
    double acumulador;
    double? Xa = double.parse(valorA!);
    print('valor de a: $Xa');
    double? Xc = double.parse(valorC!);
    print('valor de c: $Xc');
    double? Xb = double.parse(valorB!);
    print('valor de b: $Xb');
    Xb = pow(Xb, 2) as double?;
    print('valor de b: $Xb');
    acumulador = (Xb!+(-4*Xa*Xc));
    Acumulador = acumulador.toString();
    return Acumulador;
  }

}