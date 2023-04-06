import 'package:flutter/material.dart';
import 'package:lojadevelas/Models/User_model.dart';
import 'package:lojadevelas/screens/sigingupScreen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context)=> SigngupScreen()
                ),
              );

            },
            child: Text(
              'CRIAR CONTA',
              style: TextStyle(
                  fontSize: 15.0
              ),
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model!.isLoading!){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text!.isEmpty || !text.contains('@')){
                        return 'Email invalido';
                      }
                    },
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Senha'
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text!.isEmpty || text.length < 6){
                        return 'Senha invalida';
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: (){
                        if(_emailController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email vazio'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }else{
                          model.recoverPass(_emailController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Confira seu email'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text('Esqueci a senha',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(height:16,),
                  ElevatedButton(
                    onPressed: (){
                     if(_formKey.currentState!.validate()){
                    }
                     model.signIn(
                       email: _emailController.text,
                       pass: _passwordController.text,
                       onSucess: _onSuccess,
                       onFail: _onFail,
                     );

                    },
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      )
    );
  }

  _onSuccess(){
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  _onFail(){
    print('fail');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Senha ou Email Incorreto'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

}
