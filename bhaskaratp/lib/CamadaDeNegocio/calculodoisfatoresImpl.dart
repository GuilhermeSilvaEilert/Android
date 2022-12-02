import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';
import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';

class CalculoDoisFatoresImpl{

  CalculoDoisFatores? calculodoisfatores;

  CalculoDoisFatoresImpl(this.calculodoisfatores);

 void calculandodoisfatores(){
    calculodoisfatores!.CalculaDoisValores();
  }

}