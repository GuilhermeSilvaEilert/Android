import 'package:bhaskara_revisao/SOLID_interface/ValidaDados.dart';
import 'package:thread/thread.dart';

class validaValores {

    bool loopingInfinito = true;
    String? validaCampo = ' ';

    validaValores({String? ValorCampo}){
      this.validaCampo = ValorCampo;
    }

    final thread = Thread((events){
      While(loopingInfinito) {
        events.on('data', (validacampo) async {
          bool valorA = (validacampo!.toString().isEmpty
              || validacampo.toString().contains(RegExp(r'[A-Z]'))
              || validacampo.toString().contains(RegExp(r'[a-z]')));
          print(validacampo);
          if (valorA == true) {
            print('Valores Invalidos');
          } else {
            return ' ';
          }
        });
      }
    });

  }
