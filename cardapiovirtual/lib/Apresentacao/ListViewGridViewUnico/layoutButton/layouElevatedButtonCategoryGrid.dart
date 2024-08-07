import 'package:cardapiovirtual/Apresentacao/AtualizarCategoria/TelaAtualizaCategoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class layoutElevatedCategotyGrid extends StatelessWidget {
  layoutElevatedCategotyGrid({
    Key? key,
    this.Nome,
    this.Imagem,
    this.LocalStorage,
    this.id,
    this.UserRoot
  }) : super(key: key);

  String? Imagem;
  String? LocalStorage;
  String? Nome;
  String? id;
  String? UserRoot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                Imagem!,
              ),
            ),
          ),
          height: 150,
          width: 150,
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                      builder: (context) => AtualizaCategoria(
                        nomeCategoria: Nome,
                        localArquivo: LocalStorage,
                        nomeArquivo: Imagem,
                        id: id,
                      ),),);
                  } else {
                    print(LocalStorage);
                    print('Excluir');
                    await FirebaseStorage.instance
                        .ref(LocalStorage)
                        .delete();
                    await FirebaseFirestore.instance
                        .collection('Usuario raiz')
                        .doc(UserRoot)
                        .collection('Itens Cardapio')
                        .doc(id).delete();
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
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 20,
                  child: Text(
                    Nome!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
