import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Divisao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Soma.dart';
import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Subtracao.dart';
import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Multiplicacao.dart';

class ChamaCalculosFacadePositivo{

  Divisao divisao = Divisao();
  Soma soma = Soma();
  Subtracao subtracao = Subtracao();
  Multiplicacao multiplicacao = Multiplicacao();

  double? executaCalculosBasePos(double? valorA, double? valorB, double? resultadoRaiz){
    double? resultadoDoDivisor;
    double? MultiplicadorDivisao = 2;
    double? resultadoDaRaizMaisB;
    double? resultadoMaisDaDivisao;

    resultadoDoDivisor = multiplicacao.CalculaDoisValores(valorA: valorA, valorB: MultiplicadorDivisao);
    resultadoDaRaizMaisB = soma.CalculaDoisValores(valorA: resultadoRaiz, valorB: valorB);
    resultadoMaisDaDivisao = divisao.CalculaDoisValores(valorA: resultadoDaRaizMaisB, valorB: resultadoDoDivisor);
    return resultadoMaisDaDivisao;
  }

}