import 'package:bhaskara_revisao/SOLID_interface/ValidaDados.dart';

class ClassficaBhaskara implements validaDados{
  @override
  String? validaCampo({String? campoA, String? campoB, String? campoC}) {
   try {
     bool Completas = (
         campoA != '0'
      && campoB != '0'
      && campoC != '0');
     bool IncompletasTipo1 = (
         campoA == '0'
      && campoB == '0'
      && campoC == '0' );
     bool IncompletasTipo2 = (
         double.parse(campoA!) < 0
      || double.parse(campoB!) < 0
      || double.parse(campoC!) < 0);
     return 'Digite apenas Numeros';
   } on FormatException catch (e) {
    print('Digita Apenas Números');
    return 'Digite apenas Numeros';
   }
  }
  
}