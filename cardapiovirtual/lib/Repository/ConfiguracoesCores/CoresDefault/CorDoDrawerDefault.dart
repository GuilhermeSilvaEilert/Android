import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';

class CorDoDrawerDefault{

  SetCores setcores = SetCores();

  ColocaCorDefault(){

    setcores.ColocarCores(
        Blue: 85,
        Green: 90,
        Opacidade: 255,
        Red: 78,
        LocalDoApp: 'Cor Do Drawer'
    );

  }

}