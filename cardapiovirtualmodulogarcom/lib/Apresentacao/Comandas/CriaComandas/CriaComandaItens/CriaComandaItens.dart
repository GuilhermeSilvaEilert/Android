import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/Models/AddItensComandaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CriaComandasItens extends StatefulWidget {
  CriaComandasItens({
    Key? key,
    this.UserRoot,
    this.idCategoria,
    this.Categoria,
    this.NumeroComanda,
  }) : super(key: key);

  String? UserRoot;
  String? idCategoria;
  String? Categoria;
  String? NumeroComanda;

  @override
  State<CriaComandasItens> createState() => _CriaComandasItensState();
}

class _CriaComandasItensState extends State<CriaComandasItens> {
  int? contador = 0;

  CriaComandaModel criaComandaModel = CriaComandaModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CriaComandaModel>(
      model: CriaComandaModel(),
      child: ScopedModelDescendant<CriaComandaModel>(
        builder: (context, child, model) {
           return ScaffoldMultiColor(
              TextAppBar: Text('Adicione itens na comanda'),
              Body:FutureBuilder(
                future: FirebaseFirestore
                    .instance
                    .collection('Usuario raiz')
                    .doc(widget.UserRoot)
                    .collection('Itens Cardapio')
                    .doc(widget.idCategoria)
                    .collection('Itens').get(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }else{
                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics().parent,
                      slivers: [
                        SliverToBoxAdapter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              int? Counter;
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
                                          Container(
                                            width: 110,
                                            height: 110,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${snapshot.data!.docs[index]['Nome']}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(left:1),
                                              child: Row(
                                                children: [
                                                  CustomizableCounter(
                                                    showButtonText: false,
                                                    borderColor: Colors.transparent,
                                                    borderWidth: 5,
                                                    borderRadius: 100,
                                                    backgroundColor: Colors.transparent,
                                                    buttonText: "Add Item",
                                                    textColor: Colors.white,
                                                    textSize: 22,
                                                    count: 0,
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

                                                    },
                                                    onDecrement: (count) {

                                                    },
                                                  ),
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          setState(() {
                                            criaComandaModel.AdicionaComanda(
                                              onFail: onFail,
                                              UserRoot: widget.UserRoot,
                                              onSucess: onSucess,
                                              Preco: snapshot.data!.docs[index]['Preco'].toString(),
                                              Categoria: widget.Categoria,
                                              Item: snapshot.data!.docs[index]['Nome'],
                                              QuantidadeItem: Counter.toString(),
                                              NumeroComanda: widget.NumeroComanda,
                                              ImagemItem: snapshot.data!.docs[index]['Imagem']
                                            );
                                          });
                                        },
                                        child: Text(
                                          'Adicionar',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
        },
      ),

    );
  }

  onSucess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Item Adicionado'
        ),
        backgroundColor: Colors.green,
      ),
    );

    await Future.delayed(Duration(seconds: 1));

  }

  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: contador == 0 ? Text(
            'Contador Zerado'
        )
        :
        Text(
            'Problema ao Adicionar Item'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

}
