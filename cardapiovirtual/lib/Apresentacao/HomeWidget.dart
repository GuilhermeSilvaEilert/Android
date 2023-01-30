// ignore_for_file: file_names

import 'package:cardapiovirtual/Apresentacao/widgets/Boxes/Boxes.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AdicionaItemCardapio/AdicionaItemCardapio.dart';


class HomeWidget extends StatelessWidget {

  const HomeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      Body: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          children: [
            Boxes(
              child: Column(
                children: [
                  Row(
                    children:[
                      Image.asset('Assets/qrcodemesa/QRcodeMesa.jpg',
                        height: 170, width: 170,),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('GERAR QRCODE \nDA Mesa',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const Text('10 Mesas \n Cadastradas',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextButtonMultiColor(
                            largura: 140,
                            altura: 50,
                            text: const Text('ADD ou Editar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            funcao: (){},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Boxes(
              largura: 400.0,
              altura: 200.0,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    children:[
                      Image.asset('Assets/cardapio/menu.jpg',
                        height: 165, width: 165,),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('MEU \nCARDAPIO',
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
                                return Text('${snapshot.data?.docs.length} itens \nno cardapio',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }
                          ),

                          const SizedBox(height: 10,),

                          TextButtonMultiColor(
                            largura: 140,
                            altura: 50,
                            text: const Text('ADD ou Editar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            funcao: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) =>  const AdicionaItemCardapio(),));
                            },
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
