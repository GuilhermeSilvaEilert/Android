import 'package:bhaskaratp/Repository/Bhaskara.dart';

class MontaBhaskaraComposite{

  List<ComponentesBhaskara> listComponentesBhaskara = <ComponentesBhaskara>[];

  adocionaComponentesBhaskara(ComponentesBhaskara componentesBhaskara){
    this.listComponentesBhaskara.add(componentesBhaskara);
  }

  double? montaBhaskara(){
   int tamanhoLista = listComponentesBhaskara.length;
   double valores;
     listComponentesBhaskara.toList();
     print(listComponentesBhaskara.toList());
   }
}