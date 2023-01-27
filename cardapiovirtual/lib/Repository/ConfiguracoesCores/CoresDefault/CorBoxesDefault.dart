import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';

class CorBoxesDefault{

  SetCores setcores = SetCores();

  ColocaCorDefault(){

    setcores.colocarcores(
        blue: 97,
        green: 112,
        opacidade: 255,
        red: 124,
        localDoApp: 'Cor Das Boxes'
    );

  }

}