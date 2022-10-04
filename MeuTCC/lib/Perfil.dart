import 'package:flutter/material.dart';
import 'package:transparent_image_button/transparent_image_button.dart';

class Perfis extends StatefulWidget {
  const Perfis({Key? key}) : super(key: key);

  @override
  State<Perfis> createState() => _PerfisState();
}

class _PerfisState extends State<Perfis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Escolha o seu Perfil',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Aluno',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              TransparentImageButton.assets(
                'Assets/BannerApp/AlunoIcon.jpg',
                width: 240,
              ),
              SizedBox(height: 40),
              Text(
                'Professor',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              TransparentImageButton.assets(
                'Assets/BannerApp/IconeProfessor.png',
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
