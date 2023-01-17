import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault/CorBoxesDefault.dart';
import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault/CorDeFundoDefault.dart';
import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault/CorDoDrawerDefault.dart';
import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault/CorDosBotoesDefault.dart';

class CoresDefault{

  CorDosBtoesDefault corDosBtoesDefault = CorDosBtoesDefault();
  CorBoxesDefault corBoxesDefault = CorBoxesDefault();
  CorDeFundoDefault corDeFundoDefault = CorDeFundoDefault();
  CorDoDrawerDefault corDoDrawerDefault = CorDoDrawerDefault();

  ColocaCoresDefaul()async{
    await corDosBtoesDefault.ColocaCorDefault();
    await corBoxesDefault.ColocaCorDefault();
    await corDeFundoDefault.ColocaCorDefault();
    await corDoDrawerDefault.ColocaCorDefault();
  }

}