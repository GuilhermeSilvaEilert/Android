import 'package:flutter/material.dart';
import 'package:platform_detector/widgets/platform_type_widget.dart';
import 'package:transparent_image_button/transparent_image_button.dart';
import 'package:platform_detector/platform_detector.dart';

class Perfis extends StatefulWidget {
  const Perfis({Key? key}) : super(key: key);

  @override
  State<Perfis> createState() => _PerfisState();
}

class _PerfisState extends State<Perfis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          children: [
            Image.asset(
              'Assets/BannerApp/indice.png',
              width:80, height: 80,
              alignment: Alignment.center,
              scale: 0.1,
            ),
            Text(
              PlatformDetector.platform.byType(
                  defaultValue: ' ',
                  ifDesktop: 'Escolha o seu Usuario',
                  ifMobile: 'Unique'
              ),
            ),
          ],
        ),

        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.amber
        ),
        child: Center(
          child:
              PlatformDetectByType(
                ifDesktop: Container(
                    height: 300,
                    width: 650,
                    decoration:  BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all(Colors.black)
                          ),
                          onPressed: (){},
                          child: Column(
                            children: [
                              Text('Aluno',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              Image.asset(
                                'Assets/BannerApp/AlunoIcon.jpg',
                                width:300, height: 250,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all(Colors.black)
                          ),
                          onPressed: (){},
                          child: Column(
                            children: [
                              Text('Professor',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              Image.asset(
                                'Assets/BannerApp/IconeProfessor.png',
                                width:240, height: 180,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ifMobile:  Container(
                  height:600,
                  width: 300,
                  decoration:  BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Text('Escolha o seu Usuario',
                      style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Colors.black)
                        ),
                        onPressed: (){},
                        child: Column(
                          children: [
                            Text('Aluno',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Image.asset(
                              'Assets/BannerApp/AlunoIcon.jpg',
                              width:300, height: 250,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Colors.black)
                        ),
                        onPressed: (){},
                        child: Column(
                          children: [
                            Text('Professor',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Image.asset(
                              'Assets/BannerApp/IconeProfessor.png',
                              width:240, height: 180,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ),
          ),
        );
  }
}
