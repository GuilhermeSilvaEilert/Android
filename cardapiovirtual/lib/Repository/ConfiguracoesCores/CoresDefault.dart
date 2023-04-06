import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault/CorBoxesDefault.dart';
import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault/CorDeFundoDefault.dart';
import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault/CorDoDrawerDefault.dart';
import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault/CorDosBotoesDefault.dart';

class CoresDefault{

  CorDosBtoesDefault corDosBtoesDefault = CorDosBtoesDefault();
  CorBoxesDefault corBoxesDefault = CorBoxesDefault();
  CorDeFundoDefault corDeFundoDefault = CorDeFundoDefault();
  CorDoDrawerDefault corDoDrawerDefault = CorDoDrawerDefault();

  ColocaCoresDefaul({String? UserRoot})async{
    await corDosBtoesDefault.ColocaCorDefault(UserRoot: UserRoot);
    await corBoxesDefault.ColocaCorDefault(UserRoot: UserRoot);
    await corDeFundoDefault.ColocaCorDefault(UserRoot: UserRoot);
    await corDoDrawerDefault.ColocaCorDefault(UserRoot: UserRoot);
  }

}