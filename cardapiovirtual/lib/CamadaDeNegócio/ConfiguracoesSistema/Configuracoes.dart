import 'package:flutter/material.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({Key? key}) : super(key: key);

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(

        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: IconButton(
                          onPressed: (){

                          },
                          icon:Row(
                            children: [
                              Icon(Icons.color_lens_outlined),
                              Text('Cores default'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: IconButton(
                          onPressed: (){

                          },
                          icon:Row(
                            children: [
                              Icon(Icons.color_lens_outlined),
                              Text('Alterar cor de fundow'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: IconButton(
                          onPressed: (){

                          },
                          icon:Row(
                            children: [
                              Icon(Icons.color_lens_outlined),
                              Text('Alterar cor dos botões'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: IconButton(
                          onPressed: (){

                          },
                          icon:Row(
                            children: [
                              Icon(Icons.color_lens_outlined),
                              Text('Alterar cor das Boxes'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: IconButton(
                          onPressed: (){

                          },
                          icon:Row(
                            children: [
                              Icon(Icons.color_lens_outlined),
                              Text('Alterar cores do Drewer'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: IconButton(
                          onPressed: (){

                          },
                          icon:Row(
                            children: [
                              Icon(Icons.color_lens_outlined),
                              Text('Alterar cor dos botões'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          )
        ],
      ),
    );
  }
}
