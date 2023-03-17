// ignore_for_file: file_names

import 'package:cardapiovirtual/Apresentacao/widgets/Boxes/Boxes.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'AdicionaItemCardapio/AdicionaItemCardapio.dart';


class HomeWidget extends StatelessWidget {

  const HomeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      Body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
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
                  SizedBox(height: 10,),

                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection('Logins Garçons').get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5,),
                          child: GridView.builder(
                            itemBuilder: (context, index) {
                              return Card(
                                child: Boxes(
                                  altura: 100.0,
                                  largura: 100.0,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Image.network(
                                              snapshot.data!.docs[index]['Imagem'],
                                              height: 115,
                                              width: 115,
                                              fit: BoxFit.cover,
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

                                            },
                                            icon: Image.asset(
                                              'Assets/Icons/quicksetting.png',
                                              height: 15,
                                              width: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          SizedBox(width: 5,),
                                          Text(
                                              snapshot.data!.docs[index]['NomeUsuario'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white
                                            ),
                                          ),
                                           SizedBox(width: 50,),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverQuiltedGridDelegate(
                              crossAxisCount: 2,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              repeatPattern: QuiltedGridRepeatPattern.inverted,
                              pattern: snapshot.data!.docs.map((e) {
                                return QuiltedGridTile(e['y'], e['x']);
                              }).toList(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
