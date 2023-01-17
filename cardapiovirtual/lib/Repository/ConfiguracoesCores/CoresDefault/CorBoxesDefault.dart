import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';

class CorBoxesDefault{

  SetCores setcores = SetCores();

  ColocaCorDefault(){

    setcores.ColocarCores(
        Blue: 97,
        Green: 112,
        Opacidade: 255,
        Red: 124,
        LocalDoApp: 'Cor Das Boxes'
    );

  }

}