import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/Models/AtualizaItensCarrinho.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:customizable_counter/customizable_counter.dart';

class CarrinhoItensComanda extends StatefulWidget {
  CarrinhoItensComanda({
    Key? key,
    this.UserRoot,
    this.NumeroComanda,
  }) : super(key: key);

  String? UserRoot;
  String? NumeroComanda;

  @override
  State<CarrinhoItensComanda> createState() => _CarrinhoItensComandaState();
}

class _CarrinhoItensComandaState extends State<CarrinhoItensComanda> {

  AtualizaComandaModel atualizaComandaModel = AtualizaComandaModel();

  int? ValorSoma = 1;
  int? counter = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore
              .instance
              .collection('Usuario raiz')
              .doc(widget.UserRoot)
              .collection('comandas')
              .doc(widget.NumeroComanda)
              .collection('Itens')
              .get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ScaffoldMultiColor(
            TextAppBar: Text('Itens da comanda'),
            Body: Container(
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics().parent,
                slivers: [
                  SliverToBoxAdapter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                        int? Counter;
                        double? valor = double.parse(snapshot.data!.docs[index]['QuantidadeItens']);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 150, 0, 0)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        snapshot.data!.docs[index]['Imagem'],
                                        width: 100,
                                        height: 100,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data!.docs[index]['ItemComanda'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                              CustomizableCounter(
                                showButtonText: false,
                                borderColor: Colors.transparent,
                                borderWidth: 5,
                                borderRadius: 100,
                                backgroundColor: Colors.transparent,
                                buttonText: "Add Item",
                                textColor: Colors.white,
                                textSize: 22,
                                count: double.parse(snapshot.data!.docs[index]['QuantidadeItens']),
                                step: 1,
                                minCount: 1,
                                maxCount: 100,
                                incrementIcon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                decrementIcon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                onCountChange: (count) {
                                  Counter = count.toInt();
                                },
                                onIncrement: (count) {
                                 // count = Counter!;
                                },
                                onDecrement: (count) {
                                  //count = Counter!;
                                },
                              ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: (){
                                            setState(() {
                                              String Item = snapshot.data!.docs[index]['ItemComanda'];
                                              print(Counter);
                                              setState(() {
                                                FirebaseFirestore
                                                    .instance
                                                    .collection('Usuario raiz')
                                                    .doc(widget.UserRoot)
                                                    .collection('comandas')
                                                    .doc(widget.NumeroComanda)
                                                    .collection('Itens').doc(Item).delete();
                                              });
                                            });

                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                              Text(
                                               'Deletar Item',
                                                style: TextStyle(
                                                  color: Colors.white
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      SizedBox(width: 175,),
                                      TextButton(
                                        onPressed: (){
                                          setState(() {
                                            atualizaComandaModel.AtualizaComanda(
                                              ImagemItem: snapshot.data!.docs[index]['Imagem'],
                                              NumeroComanda: widget.NumeroComanda,
                                              QuantidadeItem: Counter.toString(),
                                              Preco: snapshot.data!.docs[index]['Preco'],
                                              Item: snapshot.data!.docs[index]['ItemComanda'],
                                              Categoria: snapshot.data!.docs[index]['Categoria'],
                                              onSucess: onSucess,
                                              UserRoot: widget.UserRoot,
                                              onFail: onFail,
                                            );
                                          });
                                        },
                                        child: Text(
                                          'Atualizar',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  onSucess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Comanda Emitida'
        ),
        backgroundColor: Colors.green,
      ),
    );
    await Future.delayed(Duration(seconds: 1));
  }

  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Problema ao Emitir Comanda'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

}
