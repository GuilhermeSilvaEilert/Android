import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/calculodoisfatoresImpl.dart';

import '../OperacoesAritmeticas/Potenciacao.dart';
class CalculaDelta{


  Potenciacao calculaPotenciacao = Potenciacao();
  CalculandoDelta({double? valorX2, double? valorX1, double? valorX}){
    print('iniciando delta');
    double? Potenciacao;
    print('iniciando delta2');
    Potenciacao =calculaPotenciacao.CalculaPotenciacao(valorA: valorX1);
    print(Potenciacao);
    return Potenciacao;
  }

}