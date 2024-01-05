import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class ApresentaItensComanda extends StatefulWidget {
  ApresentaItensComanda({
    Key? key,
    this.UserRoot,
    this.NumeroComanda,
  }) : super(key: key);
  String? UserRoot;
  String? NumeroComanda;

  @override
  State<ApresentaItensComanda> createState() => _ApresentaItensComandaState();
}

class _ApresentaItensComandaState extends State<ApresentaItensComanda> {
  double? Preco = 0;
  @override
  Widget build(BuildContext context) {
    print('UserRoot: ${widget.UserRoot}');
    print('NumeroComanda: ${widget.NumeroComanda}');
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 124, 112, 97),
        child: FutureBuilder(
          future: FirebaseFirestore
              .instance
              .collection('Usuario raiz')
              .doc(widget.UserRoot)
              .collection('comandas')
              .doc(widget.NumeroComanda)
              .collection('Itens').get(),
          builder: (context, snapshot) {
            if(!snapshot.hasData || snapshot.hasError){
              return Container(
                child: Center(
                  child: Text(
                    'Comanda Vazia',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }else if(snapshot == null){
              return Container(
                child: Center(
                  child: Text(
                    'Comanda Vazia',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }else{
              return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                    Preco = Preco! + double.parse(snapshot.data!.docs[index]['Preco']) * double.parse(snapshot.data!.docs[index]['QuantidadeItens']);
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 500,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 150, 0, 0)
                              ),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  ImageNetwork(
                                    image: snapshot.data!.docs[index]['Imagem'],
                                    height: 100,
                                    width: 100,
                                    fitWeb: BoxFitWeb.cover,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' Item: ${snapshot.data!.docs[index]['ItemComanda']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        ' Quantidade: ${snapshot.data!.docs[index]['QuantidadeItens']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        ' Preço Unitario: R\$ ${snapshot.data!.docs[index]['Preco']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
              );
            }
          },
        ),
      ),
    );
  }
}
