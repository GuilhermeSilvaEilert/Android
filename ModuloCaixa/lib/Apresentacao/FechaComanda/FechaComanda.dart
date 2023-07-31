import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulocaixa/Apresentacao/ApresentaItensComanda/ApresentaItensComanda.dart';
import 'package:modulocaixa/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:modulocaixa/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:modulocaixa/Negocio/ControleCaixa/ControleCaixa.dart';

class FechaComanda extends StatefulWidget {
  FechaComanda({
    Key? key,
    this.UserRoot,
    this.ValorComanda,
    this.ValorFinal,
  }) : super(key: key);

  String? UserRoot;
  String? ValorComanda;
  double? ValorFinal;

  @override
  State<FechaComanda> createState() => _FechaComandaState();
}

class _FechaComandaState extends State<FechaComanda> {

  bool? abreCalculo = true;
  bool? calcula = true;
  double? Preco;
  final _formValidateKey = GlobalKey<FormState>();
  double? Troco;

  TextEditingController CalculadoraController = TextEditingController();
  ControleCaixa controleCaixa = ControleCaixa();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      TextAppBar: Text('Comanda: ${widget.ValorComanda}'),
      Body: FutureBuilder(
        future: FirebaseFirestore
            .instance
            .collection('Usuario raiz')
            .doc(widget.UserRoot)
            .collection('comandas')
            .doc(widget.ValorComanda)
            .collection('Itens').get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverPadding(
                    padding: EdgeInsets.all(8),
                  sliver: SliverGrid.count(
                      crossAxisCount: 2,
                    children: [
                      ApresentaItensComanda(
                        NumeroComanda: widget.ValorComanda,
                        UserRoot: widget.UserRoot,
                      ),
                      Form(
                        key: _formValidateKey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            color: Color.fromARGB(255, 124, 112, 97),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButtonMultiColor(
                                  altura: 75,
                                  largura: 700,
                                  funcao: (){

                                  },
                                  text: Text(
                                      'Pagar no cartão',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextButtonMultiColor(
                                  altura: 75,
                                  largura: 700,
                                  funcao: (){
                                    setState(() {
                                      if(abreCalculo == false){
                                        abreCalculo = true;
                                      }else{
                                        abreCalculo = false;
                                      }
                                    });
                                  },
                                  text: Text(
                                      'Pagar no dinheiro',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                abreCalculo == true
                                    ? Container(
                                )
                                    : Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 700,
                                        height: 100,
                                        child: Text(
                                            'Valor total: ${widget.ValorFinal}',
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TextFormField(
                                          controller: CalculadoraController,
                                          validator: (text){
                                            final exp = RegExp(
                                              r'[0-9]',
                                              multiLine: true,
                                            );
                                            if(text == '' || text!.isEmpty){
                                              return 'Campo em Branco';
                                            }else if(!exp.hasMatch(text!)){
                                              return 'Digite apenas numeros';
                                            }else if(double.parse(CalculadoraController.text) <= double.parse(widget.ValorFinal.toString())){
                                              return 'Troco menor que o preço Total';
                                            }
                                          },
                                          style: TextStyle(
                                           fontWeight: FontWeight.bold
                                          ),
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            hintText: 'Troco',
                                            focusColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black
                                              )
                                            ),
                                            hoverColor: Colors.white,
                                            fillColor: Colors.white,
                                            filled: true,
                                            errorStyle: TextStyle(
                                              fontSize: 20
                                            )
                                          ),
                                        ),
                                      ),
                                      calcula == true
                                      ? SizedBox(height: 100)
                                      : Container(
                                        width: 700,
                                        height: 75,
                                        child: Text(
                                            'Troco: ${Troco!.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 40
                                          ),
                                        ),
                                      ),
                                      TextButtonMultiColor(
                                        largura: 700,
                                        altura: 75,
                                        text: Text(
                                            'Calcular Troco',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        funcao: (){
                                          if(_formValidateKey.currentState!.validate()){
                                            setState(() {
                                                if(calcula == true){
                                                  calcula = false;
                                                  Troco = double.parse(CalculadoraController.text) - double.parse(widget.ValorFinal.toString());
                                                }else{
                                                  calcula = true;
                                                }
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      calcula == true
                                      ? SizedBox(height: 90)
                                      : TextButtonMultiColor(
                                        largura: 700,
                                        altura: 75,
                                        text: Text(
                                          'Fechar Comanda',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        funcao: (){
                                          controleCaixa.ControleDeCaixa(
                                            UserRoot: widget.UserRoot,
                                            Entradas: widget.ValorFinal.toString(),
                                            Saidas: Troco,
                                            onSucess: onSucess,
                                            onFail: onFail,
                                          );
                                          FirebaseFirestore
                                              .instance
                                              .collection('Usuario raiz')
                                              .doc(widget.UserRoot)
                                              .collection('comandas')
                                              .doc(widget.ValorComanda)
                                              .delete();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  onSucess(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Comanda Finalizada e Registrada'
        ),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Falha ao registrar controle de caixa'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

}
