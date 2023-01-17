import 'package:cardapiovirtual/CamadaDeNeg%C3%B3cio/ConfiguracoesSistema/AlteraCores.dart';
import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({Key? key}) : super(key: key);

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {


  CoresDefault coresDefault = CoresDefault();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TextButton(
                          onPressed: (){
                            Navigator
                                .push(context, MaterialPageRoute(
                              builder: (context) => AlteraCores(),),);
                          }, 
                          child: Row(
                            children: [
                              Text('Cores',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.color_lens,
                                color: Colors.white,
                              ),
                            ],
                          ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                             Size(180, 70)
                          ),
                        ),
                        onPressed: (){
                          Navigator
                              .push(context, MaterialPageRoute(
                            builder: (context) => AlteraCores(),),);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Altera Logo',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                            SizedBox(width: 10,),
                            Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
      
    );
  }
}

