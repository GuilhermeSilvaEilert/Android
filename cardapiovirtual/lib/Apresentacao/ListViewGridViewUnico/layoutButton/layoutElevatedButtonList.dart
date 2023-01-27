import 'package:cardapiovirtual/Apresentacao/AtualizarCategoria/TelaAtualizaCategoria.dart';
import 'package:cardapiovirtual/Apresentacao/AtualizarItem/TelaDeAtualizarItem.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/PopMenuButton/PopMenuButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class layoutCategoria extends StatelessWidget {
  layoutCategoria({Key? key, this.LocalStorage, this.Imagem, this.Nome}) : super(key: key);

  String? Imagem;
  String? LocalStorage;
  String? Nome;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
              width: 200,
              padding: const EdgeInsets.all(0),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                AtualizaItemCardapio(
                                    nome: Nome),
                          ),
                        );
                      } else {
                        await FirebaseStorage.instance
                            .ref(LocalStorage)
                            .delete();
                        await FirebaseFirestore.instance
                            .collection('Itens Cardapio')
                            .doc(Nome)
                            .delete();
                        FirebaseFirestore.instance.collection('Itens Cardapio').get();
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Nome!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
