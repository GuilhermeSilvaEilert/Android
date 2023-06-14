import 'package:flutter/material.dart';

class ContadorDeItens extends StatefulWidget {
  ContadorDeItens({
    Key? key,
    this.valorIncial,
    this.funcao,
    this.retornaDados
  }) : super(key: key);

  dynamic funcao;
  int? valorIncial;
  VoidCallback? retornaDados;

  @override
  State<ContadorDeItens> createState() => _ContadorDeItensState();
}

class _ContadorDeItensState extends State<ContadorDeItens> {

  int? valorFinal;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
          builder: (context) {
            return Container(
                padding: EdgeInsets.only(left:30),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          setState(() {
                            widget.valorIncial = widget.valorIncial! + 1;
                            widget.valorIncial;
                            valorFinal = widget.valorIncial;
                            print(valorFinal);
                          });
                          print(widget.valorIncial);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        )
                    ),
                    Text('${widget.valorIncial}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          if(widget.valorIncial != 0){
                            widget.valorIncial = widget.valorIncial! - 1;
                            valorFinal = widget.valorIncial;
                            print(valorFinal);
                          }
                        });
                        print(widget.valorIncial);
                        widget.funcao = Executa(valorFinal);
                      },
                      icon: Icon(
                        color: Colors.white,
                        Icons.remove,
                      ),
                    ),
                  ],
                )
            );
          }
      ),
    );
  }
}
Executa(int? value){
  return value;
}