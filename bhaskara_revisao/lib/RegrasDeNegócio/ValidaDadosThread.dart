import 'dart:isolate';
import 'package:thread/thread.dart';

class ValidaCampo {
  final thread = Thread((events){
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
      events.on('data', (String data)async{
        if (valorA == true || valorB == true || valorC == true) {
          print('valores invalidos');
          return 'Digite Apenas Numeros';
        } else {
          return ' ';
        }
      });
    }
  });
}
