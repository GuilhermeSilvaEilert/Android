import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../AdicionaItemCardapio/AdicionaItemCardapio.dart';
import 'Drawer.dart';


class HomeWidget extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 78, 90, 85),
        ),
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 124, 112, 97),
              ),
              child: Column(
                children: [
                  Row(
                    children:[
                      Image.asset('Assets/qrcodemesa/QRcodeMesa.jpg',
                        height: 170, width: 170,),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('GERAR QRCODE \nDA Mesa',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text('10 Mesas \n Cadastradas',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 177, 66, 78),
                              ),
                            ),
                            onPressed: () {
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8, left: 30, right: 30, top: 8),
                              child: Text('ADD ou Editar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 124, 112, 97),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children:[
                      Image.asset('Assets/cardapio/menu.jpg',
                        height: 165, width: 165,),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MEU \nCARDAPIO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),

                          FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore
                                  .instance
                                  .collection('Itens Cardapio')
                                  .get(),
                              builder: (context, snapshot){
                                return Text('${snapshot.data!.docs.length} itens \nno cardapio',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }
                          ),

                          SizedBox(height: 10,),
                          TextButton(
                            style:  ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 177, 66, 78),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) =>  AdicionaItemCardapio(),));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8, left: 30, right: 30, top: 8),
                              child: Text('ADD ou Editar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
