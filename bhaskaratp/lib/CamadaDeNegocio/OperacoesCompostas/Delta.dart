import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/calculodoisfatoresImpl.dart';

import '../OperacoesAritmeticas/Potenciacao.dart';
class CalculaDelta{

  CalculoDoisFatoresImpl calculoDoisFatoresImpl = CalculoDoisFatoresImpl(calculodoisfatores:Potenciacao());
  CalculandoDelta({double? valorX2, double? valorX1, double? valorX}){
    double? Potenciacao;
    Potenciacao = calculoDoisFatoresImpl.calculandodoisfatores(valorA:valorX);
  }

}