import 'package:bhaskaratp/CamadaDeNegocio/ChamaCalculosFacade/ChamaCalculosFacade.dart';
import 'package:bhaskaratp/CamadaDeNegocio/ChamaCalculosFacade/ChamaCalculoNegativoFacade.dart';


class validaDadosStrategy{

  validaResultadoDaRaiz (String Raiz){
    if(Raiz == 'RaizSoma'){
       return ChamaCalculosFacadePositivo();
    }
    if(Raiz == 'RaizSubtracao'){
      return ChamaCalculosFacadeNegativo();
    }
    if(Raiz == 'Raiz Negativa'){
      return 'Raiz Negativa';
    }
    if(Raiz == 'Raiz Igual a Zero'){
      return 'Raiz igual a zero';
    }
  }

}