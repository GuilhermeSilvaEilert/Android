import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Multiplicacao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/calculodoisfatoresImpl.dart';

import '../OperacoesAritmeticas/Potenciacao.dart';
class CalculaDelta{

  CalculoDoisFatoresImpl calculoDoisfatoresImpl = CalculoDoisFatoresImpl(Multiplicacao());
  Potenciacao calculaPotenciacao = Potenciacao();
  double? CalculandoDelta({double? valorX2, double? valorX1, double? valorX}){
    double? ResultadoPotencia;
    double? ResultadoMultiplicacao;
    double? ResultadoRadiciacao;
    ResultadoPotencia =calculaPotenciacao.CalculaPotenciacao(valorA: valorX1);
    ResultadoMultiplicacao = calculoDoisfatoresImpl!.calculodoisfatores!.CalculaDoisValores(valorA: valorX2, valorB: valorX);
    ResultadoMultiplicacao = calculoDoisfatoresImpl!.calculodoisfatores!.CalculaDoisValores(valorA: ResultadoMultiplicacao, valorB: -4);
    ResultadoMultiplicacao = calculoDoisfatoresImpl!.calculodoisfatores!.CalculaDoisValores(valorA: ResultadoMultiplicacao, valorB: ResultadoPotencia);
    calculoDoisfatoresImpl.calculodoisfatores = Radiciacao();
    ResultadoRadiciacao = calculoDoisfatoresImpl!.calculodoisfatores!.CalculaDoisValores(valorA: ResultadoMultiplicacao);
    print(ResultadoRadiciacao);
    return ResultadoRadiciacao;
  }

}