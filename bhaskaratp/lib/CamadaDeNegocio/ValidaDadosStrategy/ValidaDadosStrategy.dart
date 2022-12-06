import 'package:bhaskaratp/CamadaDeNegocio/ChamaCalculosFacade/ChamaCalculosFacade.dart';
import 'package:bhaskaratp/CamadaDeNegocio/ChamaCalculosFacade/ChamaCalculoNegativoFacade.dart';


class validaDadosStrategy{

  String CalculoPositivo  = 'cp';
  String CalculoNegativo = 'cn';

  AcionaBhaskara (String Bhaskara, double? valorA,double? valorB, double? resultadoRaiz){
    if(Bhaskara == CalculoPositivo){
       return ChamaCalculosFacadePositivo().executaCalculosBasePos(valorA, valorB, resultadoRaiz);
    }
    if(Bhaskara == CalculoNegativo) {
      return ChamaCalculosFacadeNegativo().executaCalculosBaseNeg(valorA, valorB, resultadoRaiz);
    }
  }

}