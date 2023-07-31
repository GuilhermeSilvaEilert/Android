import 'package:acessocardapio/Apresentacao/CardapioPage/ApresentaProduto/ApresentaProduto.dart';
import 'package:acessocardapio/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:acessocardapio/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:acessocardapio/Negocio/Model/ChamaGarcomModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_network/image_network.dart';

class ItensCardapioPage extends StatefulWidget {
  ItensCardapioPage({
    Key? key,
    this.Categoria,
    this.UserRoot,
    this.NumeroDaMesa,
    this.QuantidadePessoas,
    this.QuantidadeComandas,
  }) : super(key: key);

  String? Categoria;
  String? UserRoot;
  String? QuantidadeComandas;
  String? QuantidadePessoas;
  String? NumeroDaMesa;

  @override
  State<ItensCardapioPage> createState() => _ItensCardapioPageState();
}

class _ItensCardapioPageState extends State<ItensCardapioPage> {

  int? QuantidadeChamadasAtivas;
  ChamaGarcomModel chamaGarcomModel = ChamaGarcomModel();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
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
                  .doc(widget.UserRoot)
                  .collection('MesasAguardandoAtendimento')
                  .get()
          );
          QuantidadeChamadasAtivas = await result.docs.length;
          print('chamados: $QuantidadeChamadasAtivas');
          print(widget.QuantidadeComandas);
          print(widget.QuantidadePessoas);
          print(widget.NumeroDaMesa);
          chamaGarcomModel.CriaSenhaGarcom(
            UserRoot: widget.UserRoot,
            QuantidadeComandas: widget.QuantidadeComandas,
            QuantidadePessoas: widget.QuantidadePessoas,
            NumeroMesa: widget.NumeroDaMesa,
            time: time,
            onSucess: onSucess,
            onFail: onFail,
            ValorChamado: now!.substring(4,),
          );
        },
        largura: 100,
        altura: 10,
      ),
      TextAppBar: Text('Cardapio'),
      Body: FutureBuilder(
        future:FirebaseFirestore
            .instance
            .collection('Usuario raiz')
            .doc(widget.UserRoot)
            .collection('Itens Cardapio')
            .doc(widget.Categoria)
            .collection('Itens').get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return CustomScrollView(
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
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ApresentaProduto(
                                  preco: snapshot.data!.docs[index]['Preco'],
                                  nome: snapshot.data!.docs[index]['Nome'],
                                  imagem: snapshot.data!.docs[index]['Imagem'],
                                  descricao: snapshot.data!.docs[index]['Descricao'],
                                  Email: widget.UserRoot,
                                  NumeroDaMesa: widget.NumeroDaMesa,
                                  QuantidadeComandas: widget.QuantidadeComandas,
                                  QuantidadePessoas: widget.QuantidadePessoas,
                                ),
                            )
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            ImageNetwork(
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ApresentaProduto(
                                        preco: snapshot.data!.docs[index]['Preco'],
                                        nome: snapshot.data!.docs[index]['Nome'],
                                        imagem: snapshot.data!.docs[index]['Imagem'],
                                        descricao: snapshot.data!.docs[index]['Descricao'],
                                        Email: widget.UserRoot,
                                        NumeroDaMesa: widget.NumeroDaMesa,
                                        QuantidadeComandas: widget.QuantidadeComandas,
                                        QuantidadePessoas: widget.QuantidadePessoas,
                                      ),
                                    )
                                );
                              },
                              image: snapshot.data!.docs[index]['Imagem'],
                              height: 170,
                              width: 170,
                            ),
                            Text(
                              snapshot.data!.docs[index]['Nome'],
                            ),
                            Text(
                              'R\$ ${snapshot.data!.docs[index]['Preco']}',
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
                      pattern: snapshot.data!.docs.map((e) {
                        return QuiltedGridTile(e['x'], e['y']);
                      }).toList(),
                    ),
                  ),
                )
              ],
            );
          }
        }
      ),
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
