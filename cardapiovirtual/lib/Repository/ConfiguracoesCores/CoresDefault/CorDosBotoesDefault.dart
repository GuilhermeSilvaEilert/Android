import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';

class CorDosBtoesDefault{

  SetCores setcores = SetCores();

  ColocaCorDefault({String? UserRoot}){

    setcores.colocarcores(
        blue: 0,
        green: 0,
        opacidade: 255,
        red: 150,
        localDoApp: 'Cor Dos Botoes',
        UserRoot: UserRoot,
    );

  }

}