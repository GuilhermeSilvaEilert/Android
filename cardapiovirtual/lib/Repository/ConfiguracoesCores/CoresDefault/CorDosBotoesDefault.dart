import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';

class CorDosBtoesDefault{

  SetCores setcores = SetCores();

  ColocaCorDefault(){

    setcores.ColocarCores(
        Blue: 0,
        Green: 0,
        Opacidade: 255,
        Red: 150,
        LocalDoApp: 'Cor Dos Botões'
    );

  }

}