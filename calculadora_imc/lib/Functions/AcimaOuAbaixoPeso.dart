import 'package:calculadora_imc/Functions/CalcIMC.dart';

class ObesoOuMagro{

  AcimaOuAbaixo({required double IMC}){
    if(IMC < 18.6){
      return 'Abaixo do Peso';
    }else if(IMC >= 18.6 && IMC < 24.9){
      return 'Peso Ideal';
    }else if(IMC >= 24.9 && IMC < 29.9){
      return 'Obesidade Grau I';
    }else if(IMC >= 34.9 && IMC < 34.9){
      return 'Obesidade Grau II';
    }else if(IMC >= 40){
      return 'Obesidade Grau III';
    }
  }

}