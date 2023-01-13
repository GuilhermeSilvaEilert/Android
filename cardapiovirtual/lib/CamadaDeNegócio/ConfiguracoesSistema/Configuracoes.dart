import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({Key? key}) : super(key: key);

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future:
      FirebaseFirestore
          .instance
          .collection('Configurações').doc('Cores').collection('Configura Cores').get(),
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
                  physics: NeverScrollableScrollPhysics(),
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

                      },
                      child: Row(
                        children: [
                          Icon(Icons.format_paint),
                          SizedBox(width: 10,),
                          Text(snapshot.data!.docs[index]['Nome']),
                          SizedBox(width: 20,),
                          Icon(Icons.circle,
                            color: Color.fromARGB(
                                snapshot.data!.docs[index]['Opacidade'],
                                snapshot.data!.docs[index]['Red'],
                                snapshot.data!.docs[index]['Green'],
                                snapshot.data!.docs[index]['Blue']),
                          ),
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
    );;
  }
}

