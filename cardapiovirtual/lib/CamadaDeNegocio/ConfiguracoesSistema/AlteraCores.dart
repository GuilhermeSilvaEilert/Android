// ignore_for_file: sized_box_for_whitespace

import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Model/itemModel.dart';
import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault.dart';
import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AlteraCores extends StatefulWidget {
  const AlteraCores({Key? key}) : super(key: key);

  @override
  State<AlteraCores> createState() => _AlteraCoresState();
}

class _AlteraCoresState extends State<AlteraCores> {


  CoresDefault coresDefault = CoresDefault();
  SetCores colocarCores = SetCores();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      TextAppBar: const Text('Cores'),
      BottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 124, 112, 97),
        child: Container(
          width: 50,
          height: 50,
        ),
      ),
      Body: ScopedModel<CardapioModel>(
        model: CardapioModel(),
        child: ScopedModelDescendant<CardapioModel>(
          builder: (context, child, model) {
            return FutureBuilder<QuerySnapshot>(
              future:
              FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(model.firebaseUser!.email!)
                  .collection('Configuracoes')
                  .orderBy('Nome').get(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                } else {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                  const Size(200, 100),
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
                                String nome = snapshot.data?.docs[index]['Nome'];
                                if(snapshot.data!.docs[index]['Nome'] == 'Cores Default'){
                                  coresDefault.ColocaCoresDefaul(
                                    UserRoot: model.firebaseUser!.email!
                                  );
                                }else {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return BottomSheet(
                                        builder: (context) {
                                          return Container(
                                            width: 200,
                                            height: 70,
                                            color: Colors.black12,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          colocarCores
                                                              .colocarcores(
                                                            localDoApp: nome,
                                                            red: 158,
                                                            opacidade: 255,
                                                            green: 158,
                                                            blue: 158,
                                                            UserRoot: model.firebaseUser!.email!
                                                          );
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(Icons
                                                          .circle,
                                                        color: Colors.grey,
                                                        size: 60,
                                                      ),
                                                    ),

                                                    const SizedBox(width: 7,),

                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          colocarCores
                                                              .colocarcores(
                                                            localDoApp: nome,
                                                            red: 244,
                                                            opacidade: 255,
                                                            green: 67,
                                                            blue: 54,
                                                            UserRoot: model.firebaseUser!.email!
                                                          );
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(Icons
                                                          .circle,
                                                        color: Colors.red,
                                                        size: 60,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 7,),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          colocarCores
                                                              .colocarcores(
                                                            localDoApp: nome,
                                                            red: 33,
                                                            opacidade: 255,
                                                            green: 150,
                                                            blue: 243,
                                                            UserRoot: model.firebaseUser!.email!
                                                          );
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(Icons
                                                          .circle,
                                                        color: Colors.blue,
                                                        size: 60,
                                                      ),
                                                    ),

                                                    const SizedBox(width: 7,),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          colocarCores
                                                              .colocarcores(
                                                            localDoApp: nome,
                                                            red: 0,
                                                            opacidade: 255,
                                                            green: 0,
                                                            blue: 0,
                                                            UserRoot: model.firebaseUser!.email!
                                                          );
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(Icons
                                                          .circle,
                                                        color: Colors.black,
                                                        size: 60,
                                                      ),
                                                    ),

                                                    const SizedBox(width: 7,),

                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          colocarCores
                                                              .colocarcores(
                                                            localDoApp: nome,
                                                            red: 255,
                                                            opacidade: 255,
                                                            green: 255,
                                                            blue: 255,
                                                            UserRoot: model.firebaseUser!.email!
                                                          );
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(Icons
                                                          .circle,
                                                        color: Colors.white,
                                                        size: 60,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 7,),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          colocarCores
                                                              .colocarcores(
                                                            localDoApp: nome,
                                                            red: 76,
                                                            opacidade: 255,
                                                            green: 175,
                                                            blue: 80,
                                                            UserRoot: model.firebaseUser!.email!
                                                          );
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(Icons
                                                          .circle,
                                                        color: Colors.green,
                                                        size: 60,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 7,),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          colocarCores
                                                              .colocarcores(
                                                            localDoApp: nome,
                                                            red: 255,
                                                            opacidade: 255,
                                                            green: 235,
                                                            blue: 59,
                                                            UserRoot: model.firebaseUser!.email!
                                                          );
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(Icons
                                                          .circle,
                                                        color: Colors.yellow,
                                                        size: 60,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 7,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }, onClosing: () {},
                                      );
                                    },
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.format_paint),
                                  const SizedBox(width: 10,),
                                  Text(snapshot.data!.docs[index]['Nome']),
                                  const SizedBox(width: 20,),
                                ],
                              ) ,
                            );
                          },
                        ),
                      )
                    ],
                  );
                }
              },
            );
          }
        ),
      ),
    );
  }
}
