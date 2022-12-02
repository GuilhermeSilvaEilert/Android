import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';
import 'package:bhaskaratp/CamadaDeNegocio/OperacoesAritmeticas/Radiciacao.dart';

class CalculoDoisFatoresImpl{

  _CalculoDoisFatoresImpl(){}

  static CalculoDoisFatoresImpl? instancia;

  CalculoDoisFatoresImpl? getInstancia(){
    if(instancia == null) {
      instancia = CalculoDoisFatoresImpl();
    }
    return instancia;
    }

  CalculoDoisFatores? calculodoisfatores;

  CalculoDoisFatoresImpl({CalculoDoisFatores? calculodoisfatores}){
    this.calculodoisfatores = calculodoisfatores;
  }

  double? calculandodoisfatores({double? valorA, double? valorB}){
    double? resultado;
    resultado = calculodoisfatores?.CalculaDoisValores(valorA: valorA, valorB: valorB);
    return  resultado;
  }

}