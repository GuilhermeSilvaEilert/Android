import 'package:bhaskara_revisao/Calculos/DELTA.dart';
import 'package:bhaskara_revisao/CalculosImpl.dart';
import 'package:bhaskara_revisao/SOLID_interface/ValidaDados.dart';

class ClassficaBhaskara implements validaDados{
  @override
  String? validaCampo({String? campoA, String? campoB, String? campoC}) {

    int ClassificadordorBaseRaiz = 0;

    CalculoImpl calculoImpl = CalculoImpl(CalculaDelta());
    String? ResultadoDelta = calculoImpl.calculobase!.CalculoDoisFatores(
        valorA: campoA,
        valorB: campoB,
        valorC: campoC,);

     bool RaizNegativa = (double.parse(ResultadoDelta!) < ClassificadordorBaseRaiz);
     bool RaizZero = (double.parse(ResultadoDelta!) == ClassificadordorBaseRaiz);
     bool RaizNormal = (double.parse(ResultadoDelta!) > ClassificadordorBaseRaiz);

     if(RaizNegativa == true){
       return 'Raiz negativa';
     }
    if(RaizZero == true){
      return 'Raiz igual a zero';
    }
    if(RaizNormal == true){
      return 'Raiz Normal';
    }
  }
}
  
