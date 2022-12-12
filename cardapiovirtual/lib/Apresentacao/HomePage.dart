import 'dart:io';
import 'package:cardapiovirtual/Apresentacao/AdicionaItemCardapio/AdicionaItemCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/Widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AdmHomePage extends StatefulWidget {
  const AdmHomePage({Key? key}) : super(key: key);

  @override
  State<AdmHomePage> createState() => _AdmHomePageState();
}

class _AdmHomePageState extends State<AdmHomePage> {
  final _pageController = PageController();

  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 78, 90, 85),
              title: Text('Seu Cardapio', style:TextStyle(fontWeight: FontWeight.bold),),
          ),
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
                                style:  ButtonStyle(
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
                          height: 170, width: 170,),
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
                              Text('60 itens \nno cardapio',
                              style: TextStyle(
                                  color: Colors.white,
                                ),
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
        ),
      ],
    );
  }
}
