import 'package:flutter/material.dart';

class DrawerTile extends StatefulWidget {
   DrawerTile({Key? key, required this.icon, required this.text, required this.pageController, required this.page}) : super(key: key);

  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.pageController.page!.round() == widget.page ?
      Color.fromARGB(52, 26, 15, 15) : Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          widget.pageController.jumpToPage(widget.page);
        },
        child:Container(
          height: 60,
          child: Row(
            children:[
              Icon(
                widget.icon,
                size:32.0,
                color: widget.pageController.page!.round() == widget.page ?
                 Colors.white : Colors.black,
              ),
              SizedBox(width: 32,),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.pageController.page!.round() == widget.page ?
                  Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
