import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';

class CalculoDoisFatoresImpl{

  CalculoDoisFatores? calculodoisfatores;

  CalculoDoisFatoresImpl(CalculoDoisFatores? calculodoisfatores){
    this.calculodoisfatores = calculodoisfatores;
  }

  void calculandodoisfatores(){
    calculodoisfatores?.CalculaDoisValores();
  }

}