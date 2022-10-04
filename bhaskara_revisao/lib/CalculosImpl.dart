import 'package:bhaskara_revisao/SOLID_interface/CALCULOBASE.dart';

class CalculoImpl{
  Calculobase? calculobase;

  CalculoImpl(Calculobase? calculobase){
    this.calculobase = calculobase;
  }

  void calculoBase(){
    calculobase?.CalculoDoisFatores();
  }

}