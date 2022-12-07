import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Multiplicacao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Subtracao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/calculodoisfatoresImpl.dart';

import '../OperacoesAritmeticas/Potenciacao.dart';
class CalculaDelta{

  double? ResultadoPotencia;
  double? ResultadoMultiplicacao;
  double? ResultadoRadiciacao;

  CalculoDoisFatoresImpl calculoDoisfatoresImpl = CalculoDoisFatoresImpl(Multiplicacao());
  Potenciacao calculaPotenciacao = Potenciacao();
  double? CalculandoDelta({double? valorX2, double? valorX1, double? valorX}){

    ResultadoPotencia =calculaPotenciacao.CalculaPotenciacao(valorA: valorX1);
    ResultadoMultiplicacao = calculoDoisfatoresImpl!.calculodoisfatores!.CalculaDoisValores(valorA: valorX2, valorB: valorX);
    ResultadoMultiplicacao = calculoDoisfatoresImpl!.calculodoisfatores!.CalculaDoisValores(valorA: ResultadoMultiplicacao, valorB: -4);
    calculoDoisfatoresImpl.calculodoisfatores = Subtracao();
    ResultadoMultiplicacao = calculoDoisfatoresImpl!.calculodoisfatores!.CalculaDoisValores(valorA: ResultadoMultiplicacao, valorB: ResultadoPotencia);
    calculoDoisfatoresImpl.calculodoisfatores = Radiciacao();
    ResultadoRadiciacao = calculoDoisfatoresImpl!.calculodoisfatores!.CalculaDoisValores(valorA: ResultadoMultiplicacao);
    print(ResultadoRadiciacao);
    return ResultadoRadiciacao;
  }

}