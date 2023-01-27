import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';

class CorDoDrawerDefault{

  SetCores setcores = SetCores();

  ColocaCorDefault(){

    setcores.colocarcores(
        blue: 158,
        green: 158,
        opacidade: 255,
        red: 158,
        localDoApp: 'Cor Do Drawer'
    );

  }

}