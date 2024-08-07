import 'package:cardapiovirtual/Apresentacao/AtualizarItem/TelaDeAtualizarItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class layoutItens extends StatefulWidget {
  layoutItens({Key? key,
    this.Nome,
    this.Imagem,
    this.LocalStorage,
    this.Preco,
    this.Categoria}) : super(key: key);

  String? Imagem;
  String? LocalStorage;
  String? Nome;
  double? Preco;
  String?  Categoria;

  @override
  State<layoutItens> createState() => _layoutItensState();
}

class _layoutItensState extends State<layoutItens> {
  @override
  Widget build(BuildContext context) {

    var NomeProduto = widget.Nome!.toString().split('\n');

    return Row(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.Imagem!,
                  ),
                ),
              ),
              height:180,
              width: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    nome: widget.Nome),
                          ),
                        );
                      } else {
                        await FirebaseStorage.instance
                            .ref(widget.LocalStorage)
                            .delete();
                        await FirebaseFirestore.instance
                            .collection('Itens Cardapio')
                            .doc(widget.Categoria)
                            .collection('Itens')
                            .doc(widget.Nome)
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
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),

                ],
              ),
            ),

          ],
        ),
        const SizedBox(width: 20,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 10,),
            Text(
              widget.Nome!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),

            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'R\$' + widget.Preco.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
