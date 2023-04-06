import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';

class CorDeFundoDefault{

  SetCores setcores = SetCores();

  ColocaCorDefault({String? UserRoot}){

    setcores.colocarcores(
      blue: 85,
      green: 90,
      opacidade: 255,
      red: 78,
      localDoApp: 'Cor De Fundo',
      UserRoot: UserRoot,
    );

  }

}