import 'package:bhaskaratp/CamadaDeNegocio/Interface/CalculoDoisFatores.dart';

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

  void calculandodoisfatores(){
    calculodoisfatores?.CalculaDoisValores();
  }

}