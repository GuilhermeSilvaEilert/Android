import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({Key? key, required this.icon, required this.text, required this.pageController, required this.page}) : super(key: key);

  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: pageController.page!.round() == page ?
      const Color.fromARGB(52, 26, 15, 15) : Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child:Container(
          height: 60,
          child: Row(
            children:[
              Icon(
                icon,
                size:32.0,
                color: pageController.page!.round() == page ?
                Colors.white : Colors.black,
              ),
              const SizedBox(width: 32,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: pageController.page!.round() == page ?
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