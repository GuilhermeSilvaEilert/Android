import 'package:bhaskara_revisao/SOLID_interface/CALCULOBASE.dart';

class CalculoImpl{
  Calculobase? calculobase;

  CalculoImpl(this.calculobase);

  void calculoBase(){
    calculobase?.CalculoDoisFatores();
  }

}