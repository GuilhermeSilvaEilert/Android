import 'package:bhaskara_revisao/SOLID_interface/ValidaDados.dart';

class validaCampoIMPL{
  validaDados? validadados;

  validaCampoIMPL(this.validadados);

  void validardados(){
    validadados?.validaCampo();
  }
}