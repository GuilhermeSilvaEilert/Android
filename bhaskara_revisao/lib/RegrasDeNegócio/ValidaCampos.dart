import 'package:bhaskara_revisao/SOLID_interface/ValidaDados.dart';

class validaValores implements validaDados{
  @override
  String? validaCampo({String? campoA, String? campoB, String? campoC}) {

    bool valorA = (campoA!.isEmpty
                || campoA.contains(RegExp(r'[A-Z]'))
                || campoA.contains(RegExp(r'[a-z]')));

    bool valorB = (campoB!.isEmpty
                || campoB.contains(RegExp(r'[A-Z]'))
                || campoB.contains(RegExp(r'[a-z]')));

    bool valorC = (campoC!.isEmpty
                || campoC.contains(RegExp(r'[A-Z]'))
                || campoC.contains(RegExp(r'[a-z]')));

       if(valorA == true || valorB == true || valorC == true){
      print('valores invalidos');
      return 'Digite Apenas Numeros';
    }else{
      return ' ';
    }


  }

}