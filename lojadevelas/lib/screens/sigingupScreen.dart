
import 'package:flutter/material.dart';
import 'package:lojadevelas/Models/User_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SigngupScreen extends StatefulWidget {
   SigngupScreen({Key? key}) : super(key: key);

  @override
  State<SigngupScreen> createState() => _SigngupScreenState();
}

class _SigngupScreenState extends State<SigngupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _addressController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cria Conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if(model.isLoading!)
            return Center(child: CircularProgressIndicator(),);
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: 'Nome Completo'
                  ),
                  validator: (text){
                    if(text!.isEmpty){
                      return 'Nome invalido';
                    }
                  },
                ),
                SizedBox(height: 16,),
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
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: 'Endereco'
                  ),
                  validator: (text){
                    if(text!.isEmpty ){
                      return 'Endereço invalido ';
                    }
                  },
                ),

                SizedBox(height:16,),

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

                SizedBox(height:16,),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      Map<String, dynamic>? userData = {
                        'name': _nameController.text,
                        'email': _emailController.text,
                        'adddress': _addressController.text,
                      };
                      print('salvando');
                      model.signUp(
                          userData: userData,
                          pass: _passwordController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                      );
                    }
                  },
                  child: Text(
                    'Criar Conta',
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
        },
      ),
    );
  }

  _onSuccess(){
    print('Sucesso');
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text('Conta Criada'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

    _onFail(){
     print('fail');
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text('Falha ao Criar conta'),
         backgroundColor: Colors.green,
         duration: Duration(seconds: 2),
       ),
     );
  }
}
