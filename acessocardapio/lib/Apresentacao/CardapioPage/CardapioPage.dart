import 'package:acessocardapio/Apresentacao/CardapioPage/ItensPage/ItensCardapioPage.dart';
import 'package:acessocardapio/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:acessocardapio/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:acessocardapio/Negocio/Model/ChamaGarcomModel.dart';
import 'package:acessocardapio/Negocio/Model/CriaSenhaGarcom/CriaSenhaGarcom.dart';
import 'package:acessocardapio/Negocio/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_network/image_network.dart';

class CardapioPage extends StatefulWidget {
  CardapioPage({
    Key? key,
    this.Empresa,
    this.Email,
    this.NumeroDaMesa,
    this.QuantidadeComandas,
    this.QuantidadePessoas,
  }) : super(key: key);

  String? Empresa;
  String? Email;
  String? QuantidadePessoas;
  String? QuantidadeComandas;
  String? NumeroDaMesa;

  @override
  State<CardapioPage> createState() => _CardapioPageState();
}

class _CardapioPageState extends State<CardapioPage> {

  String? UserRoot;
  int? QuantidadeChamadasAtivas;
  ChamaGarcomModel chamaGarcomModel = ChamaGarcomModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChamaGarcomModel>(
        model: ChamaGarcomModel(),
        child: ScopedModelDescendant<ChamaGarcomModel>(
          builder: (context, child, model) {
            return FutureBuilder(
              future: FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(widget.Email)
                  .collection('Itens Cardapio').get(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }else{
                  return ScaffoldMultiColor(
                    TextAppBar: Text('Cardapio'),
                    actions: TextButtonMultiColor(
                    text: Text(
                      'Chamar',
                      style: TextStyle(color: Colors.white),
                    ),
                    funcao: () async {
                      String now = DateTime.timestamp().hashCode.toString();
                      String time = DateTime.timestamp().toString();
                      final QuerySnapshot result = await Future.value(
                          FirebaseFirestore.instance
                              .collection('Usuario raiz')
                              .doc(widget.Email)
                              .collection('MesasAguardandoAtendimento')
                              .get()
                      );
                      QuantidadeChamadasAtivas = await result.docs.length;
                      print('chamados: $QuantidadeChamadasAtivas');
                      print(widget.Email);
                      print(widget.QuantidadeComandas);
                      print(widget.QuantidadePessoas);
                      print(widget.NumeroDaMesa);
                      model.CriaSenhaGarcom(
                        UserRoot: widget.Email,
                        QuantidadeComandas: widget.QuantidadeComandas,
                        QuantidadePessoas: widget.QuantidadePessoas,
                        ValorChamado: now!.substring(5,),
                        NumeroMesa: widget.NumeroDaMesa,
                        time: time,
                        onSucess: onSucess,
                        onFail: onFail,
                      );
                    },
                    largura: 100,
                    altura: 10,
                  ),
                    Body: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: GridView.builder(
                            itemBuilder: (context, index) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.only(top: 5),
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                    const Size(180, 180),
                                  ),
                                  shadowColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 124, 112, 97),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent
                                  ),
                                  enableFeedback: true,
                                  shape: MaterialStateProperty.all(
                                      ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      )
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator
                                      .of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => ItensCardapioPage(
                                      UserRoot: widget.Email,
                                      Categoria: snapshot.data!.docs[index]['id'],
                                      QuantidadePessoas: widget.QuantidadePessoas,
                                      QuantidadeComandas: widget.QuantidadeComandas,
                                      NumeroDaMesa: widget.NumeroDaMesa,
                                    ),
                                  ),
                                  );
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      ImageNetwork(
                                        onTap: (){
                                          Navigator
                                              .of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => ItensCardapioPage(
                                              UserRoot: widget.Email,
                                              Categoria: snapshot.data!.docs[index]['id'],
                                              QuantidadePessoas: widget.QuantidadePessoas,
                                              QuantidadeComandas: widget.QuantidadeComandas,
                                              NumeroDaMesa: widget.NumeroDaMesa,
                                            ),
                                          ),
                                          );
                                        },
                                        image: snapshot.data!.docs[index]['Imagem'],
                                        height: 170,
                                        width: 170,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['Nome'],
                                      ),
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
                              pattern: snapshot.data!.docs.map((e) =>
                                QuiltedGridTile(e['y'], e['x']),
                              ).toList()
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
            );
          },
        )
    );
  }
  onSucess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Chamada realizada'
        ),
        backgroundColor: Colors.green,
      ),
    );
    await Future.delayed(Duration(seconds: 2));
  }

  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Chamada não realizada'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
