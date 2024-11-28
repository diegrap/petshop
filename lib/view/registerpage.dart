import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petshop_final/model/user_model.dart';
import '../bloc/manage_bloc.dart';
import '../provider/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  final FirebaseAuthenticationService authService =
      FirebaseAuthenticationService();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar'),
      ),
      body: BlocListener<ManageBloc, ManageState>(
        listener: (context, state) {
          // Listener para estados futuros, se necessário
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registre-se com seu e-mail',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Color(0xFF212121)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBDBDBD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Color(0xFF212121)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBDBDBD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Color(0xFF212121)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBDBDBD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      String nome = nomeController.text.trim();
                      String email = emailController.text.trim();
                      String senha = senhaController.text.trim();

                      if (nome.isNotEmpty &&
                          email.isNotEmpty &&
                          senha.isNotEmpty) {
                        UserModel? user = await authService
                            .createUserWithEmailAndPassword(nome, email, senha);
                        if (user != null) {
                          // Sucesso no registro, navega para a tela de produtos
                          Navigator.pushReplacementNamed(
                            context,
                            '/login',
                            arguments: emailController.text,
                          );
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            '/login',
                            arguments: emailController.text,
                          );
                        }
                      } else {
                        // Exibir mensagem se os campos estiverem vazios
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Preencha todos os campos.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC38D4C),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1.4,
                        letterSpacing: 0.2,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
