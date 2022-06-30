import 'package:calculadora_imc/Functions/AcimaOuAbaixoPeso.dart';

class CalculoIMC extends ObesoOuMagro{

  calcimc({required String altura, required String peso}) {
    double alt = double.parse(altura);
    double pes = double.parse(peso);
    String result;
    double IMC;
    IMC = pes/(alt*alt);
    result = super.AcimaOuAbaixo(IMC:IMC);
    String IMCString = IMC.toStringAsFixed(2);
    print(IMC);
    return ('$result ($IMCString)');
  }
}