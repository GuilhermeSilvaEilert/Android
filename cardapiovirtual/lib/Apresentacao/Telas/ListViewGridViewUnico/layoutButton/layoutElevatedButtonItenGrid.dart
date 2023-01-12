import 'package:cardapiovirtual/Apresentacao/Telas/TelaDeAtualizarItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class layoutElevatedGridItens extends StatelessWidget {
   layoutElevatedGridItens({
     Key? key,
     this.Imagem,
     this.Descricao,
     this.LocalStorage,
     this.categoria,
     this.Nome,
     this.Preco
   }) : super(key: key);

  String? Imagem;
  String? Nome;
  double? Preco;
  String? Descricao;
  String? LocalStorage;
  String? categoria;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          Imagem!,
          fit: BoxFit.cover,
          width: 300,
          height: 300,
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Nome!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  PopupMenuButton(
                    itemBuilder: (context) {
                      var list = <PopupMenuEntry<Object>>[];
                      list.add(
                        PopupMenuItem(
                          value: 2,
                          child: Row(
                            children: const [
                              Icon(Icons.delete, color: Colors.red),
                              Text('Deletar')
                            ],
                          ),
                        ),
                      );
                      list.add(
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                              Text('Editar')
                            ],
                          ),
                        ),
                      );
                      return list;
                    },
                    onSelected: (value) async {
                      if (value == 1) {
                        Navigator
                            .of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => AtualizaItemCardapio(
                            Preco: Preco.toString(),
                            Nome: Nome,
                            Imagem: Imagem,
                            Descricao: Descricao,
                            Categoria: categoria,
                            LocalStorage:LocalStorage,
                          ),),
                        );
                      } else {
                        await FirebaseStorage.instance
                            .ref(LocalStorage)
                            .delete();
                        await FirebaseFirestore.instance
                            .collection('Itens Cardapio')
                            .doc(categoria).collection('Itens').doc(Nome)
                            .delete();
                      }
                    },
                    icon: Image.asset(
                      'Assets/Icons/quicksetting.png',
                      fit: BoxFit.cover,
                      height: 20,
                      width: 20,
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('R\$' + Preco.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
