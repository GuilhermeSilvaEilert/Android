import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/Models/CardapioModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeGarcom extends StatefulWidget {
  const HomeGarcom({Key? key}) : super(key: key);

  @override
  State<HomeGarcom> createState() => _HomeGarcomState();
}

class _HomeGarcomState extends State<HomeGarcom> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CardapioModel>(
      model: CardapioModel(),
      child: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          return FutureBuilder(
              future: FirebaseFirestore
                  .instance
                  .collection('Usuario Garcom')
                  .doc('Usuarios')
                  .collection(model.firebaseUser!.email!).get(),
              builder: (context, snapshot) {
                return ScaffoldMultiColor(
                  Body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              width: 400,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 124, 112, 97)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        snapshot.data!.docs[0]['Imagem'],
                                        height: 100,
                                        width: 100,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Ola',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Text(
                                                snapshot.data!.docs[0]['Nome'],
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 40),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(
                                                    Color.fromARGB(255, 150, 0, 0),
                                                  ),
                                                  fixedSize: MaterialStateProperty.all(
                                                      Size(125, 50)
                                                  ),
                                                ),
                                                onPressed: (){},
                                                child: Text(
                                                    'Ver Comandas',
                                                    style: TextStyle(
                                                      color: Colors.white
                                                    ),
                                                ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                 ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        },
      ),

    );
  }
}
