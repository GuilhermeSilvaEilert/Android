import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../Repository/ConectaFirebase.dart';
import '../ItensDoCardapio.dart';

class ListaItens extends StatelessWidget {
  ListaItens({Key? key}) : super(key: key);

  ConectaFirebase conectaFirebase = ConectaFirebase();

  String? Itens;
  var existeItens;
  int? existeDados;
  int? resultadoConsulta;
  var decisao;
  int? consultaCategorias;

  Future<int?> ValidaExistenciaDeDados(String? Categoria) async {
    final QuerySnapshot result = await Future.value(
      FirebaseFirestore.instance
          .collection('Itens Cardapio')
          .doc(Categoria)
          .collection('Itens')
          .get(),
    );
    print('ValidaExistenciaDeDados ${result.docs.length}');

    resultadoConsulta = result.docs.length;

    return resultadoConsulta;
  }

  Future<int> ValidaExistenciaCategoria() async {
    final QuerySnapshot result = await Future.value(
      FirebaseFirestore.instance.collection('Itens Cardapio').get(),
    );

    consultaCategorias = result.docs.length;

    return consultaCategorias!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('Itens Cardapio').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(200, 140),
                  ),
                  shadowColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  enableFeedback: true,
                ),
                onPressed: () async {
                  Itens = snapshot.data!.docs[index]['Nome'];
                  await ValidaExistenciaDeDados(Itens);
                  if (resultadoConsulta! > 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItensDoCardapio(Itens: Itens!),
                    ));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          icon: const Icon(
                            Icons.crisis_alert_outlined,
                            color: Color.fromARGB(255, 150, 0, 0),
                            size: 150,
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 124, 112, 97),
                          title: Text(
                            'A categoria $Itens está vazia \n',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snapshot.data?.docs[index]['Imagem'],
                              ),
                            ),
                          ),
                          height: 100,
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
                                      onTap: () async {
                                        decisao = 1;
                                        print(decisao);
                                      },
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
                                icon: Image.asset(
                                  'Assets/Icons/quicksetting.png',
                                  fit: BoxFit.cover,
                                  height: 20,
                                  width: 20,
                                ),
                                onSelected: (value) async {
                                  if (value == 1) {
                                    print('EDITAR');
                                  } else {
                                    await FirebaseStorage.instance
                                        .ref(snapshot.data!.docs[index]
                                            ['LocalStorage'])
                                        .delete();
                                    await FirebaseFirestore.instance
                                        .collection('Itens Cardapio')
                                        .doc(snapshot.data!.docs[index]['Nome'])
                                        .delete();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data?.docs[index]['Nome'],
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
                ),
              );
            },
          );
        }
      },
    );
  }
}
