import 'package:cardapiovirtual/Repository/ConfiguracoesCores/CoresDefault.dart';
import 'package:cardapiovirtual/Repository/SetCores/ColocaCores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlteraCores extends StatefulWidget {
  const AlteraCores({Key? key}) : super(key: key);

  @override
  State<AlteraCores> createState() => _AlteraCoresState();
}

class _AlteraCoresState extends State<AlteraCores> {


  CoresDefault coresDefault = CoresDefault();
  SetCores colocarCores = SetCores();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 90, 85),
       centerTitle: true,
       title: const Text('Cores'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 124, 112, 97),
        child: Container(
          width: 50,
          height: 50,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 78, 90, 85),
      body: FutureBuilder<QuerySnapshot>(
        future:
        FirebaseFirestore
            .instance
            .collection('Configurações').doc('Cores').collection('Configura Cores').orderBy('Nome').get(),
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
                    physics: const NeverScrollableScrollPhysics(),
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

                          String Nome = snapshot.data?.docs[index]['Nome'];

                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BottomSheet(
                                    builder: (context){
                                      return Container(
                                        width: 200,
                                        height: 70,
                                        color: Colors.black12,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      colocarCores.ColocarCores(
                                                        LocalDoApp: Nome,
                                                        Red: 158,
                                                        Opacidade: 255,
                                                        Green: 158,
                                                        Blue: 158,
                                                      );
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.circle,
                                                    color: Colors.grey,
                                                    size: 60,
                                                  ),
                                                ),

                                                const SizedBox(width: 7,),

                                                IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      colocarCores.ColocarCores(
                                                        LocalDoApp: Nome,
                                                        Red: 244,
                                                        Opacidade: 255,
                                                        Green: 67,
                                                        Blue: 54,
                                                      );
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.circle,
                                                    color: Colors.red,
                                                    size: 60,
                                                  ),
                                                ),
                                                const SizedBox(width: 7,),
                                                IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      colocarCores.ColocarCores(
                                                        LocalDoApp: Nome,
                                                        Red: 33,
                                                        Opacidade: 255,
                                                        Green: 150,
                                                        Blue: 243,
                                                      );
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.circle,
                                                    color: Colors.blue,
                                                    size: 60,
                                                  ),
                                                ),

                                                const SizedBox(width: 7,),
                                                IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      colocarCores.ColocarCores(
                                                        LocalDoApp: Nome,
                                                        Red: 0,
                                                        Opacidade: 255,
                                                        Green: 0,
                                                        Blue: 0,
                                                      );
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.circle,
                                                    color: Colors.black,
                                                    size: 60,
                                                  ),
                                                ),

                                                const SizedBox(width: 7,),

                                                IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      colocarCores.ColocarCores(
                                                        LocalDoApp: Nome,
                                                        Red: 255,
                                                        Opacidade: 255,
                                                        Green: 255,
                                                        Blue: 255,
                                                      );
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.circle,
                                                    color: Colors.white,
                                                    size: 60,
                                                  ),
                                                ),
                                                const SizedBox(width: 7,),
                                                IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      colocarCores.ColocarCores(
                                                        LocalDoApp: Nome,
                                                        Red: 76,
                                                        Opacidade: 255,
                                                        Green: 175,
                                                        Blue: 80,
                                                      );
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.circle,
                                                    color: Colors.green,
                                                    size: 60,
                                                  ),
                                                ),
                                                const SizedBox(width: 7,),
                                                IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      colocarCores.ColocarCores(
                                                        LocalDoApp: Nome,
                                                        Red: 255,
                                                        Opacidade: 255,
                                                        Green: 235,
                                                        Blue: 59,
                                                      );
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.circle,
                                                    color: Colors.yellow,
                                                    size: 60,
                                                  ),
                                                ),
                                                const SizedBox(width: 7,),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }, onClosing: () {  },
                                );
                              },
                          );

                          if(snapshot.data!.docs[index]['Nome'] == 'Cores Default'){
                            coresDefault.ColocaCoresDefaul();
                          }

                        },
                        child: Row(
                          children: [
                            const Icon(Icons.format_paint),
                            const SizedBox(width: 10,),
                            Text(snapshot.data!.docs[index]['Nome']),
                            const SizedBox(width: 20,),
                            /*Icon(Icons.circle,
                              color: Color.fromARGB(
                                  snapshot.data!.docs[index]['Opacidade'],
                                  snapshot.data!.docs[index]['Red'],
                                  snapshot.data!.docs[index]['Green'],
                                  snapshot.data!.docs[index]['Blue']),
                            ),
                            */
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
      ),
    );
  }
}
