import 'package:flutter/material.dart';

class PopMenuButtonWidget extends StatefulWidget {
  PopMenuButtonWidget({
    Key? key,
    this.Funcao2,
    this.Funcao1,
    this.Funcao3,
    this.value1,
    this.value2,
    this.Icon1,
    this.Icon2
  }) : super(key: key);

  var Funcao1;
  var Funcao2;
  var Funcao3;
  var value1;
  var value2;
  var Icon1;
  var Icon2;

  @override
  State<PopMenuButtonWidget> createState() => _PopMenuButtonWidgetState();
}

class _PopMenuButtonWidgetState extends State<PopMenuButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        list.add(
          PopupMenuItem(
            onTap: widget.Funcao1,
            value: 2,
            child: widget.Icon1
          ),
        );
        list.add(
          PopupMenuItem(
            onTap: widget.Funcao2,
            value: 1,
            child: widget.Icon2,
          ),
        );
        return list;

      },
      icon: const Icon(Icons.filter_alt),
      onSelected: widget.Funcao3,

    );
  }
}
