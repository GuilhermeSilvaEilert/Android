import 'package:bhaskaratp/CamadaDeNegocio/calculodoisfatoresImpl.dart';
class IniciaBhaskara {

  _IniciaBhaskara(){}

   static _IniciaBhaskara instancia;

  IniciaBhaskara getInstancia(){
    if(instancia == null) {
      instancia = _IniciaBhaskara();
    }
    return instancia;
  }
  }



}