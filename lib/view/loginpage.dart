import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/manage_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController senhaController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey();

    bool _segredo2 = true;

    final String email2 = ModalRoute.of(context)!.settings.arguments as String;

    if (_segredo2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário $email2 cadastrado com sucesso!'),
            duration: Duration(seconds: 3),
          ),
        );
      });
      _segredo2 = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Conecte-se'),
        backgroundColor: Color(0xFFC38D4C), // Cor personalizada do AppBar
      ),
      body: BlocListener<ManageBloc, ManageState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Se login for bem-sucedido, redireciona para a página de produtos
            Navigator.pushReplacementNamed(context, '/products');
          } else if (state is LoginError) {
            // Se ocorrer erro no login, exibe a mensagem de erro
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de Login
                  Text(
                    'Entre com seu e-mail',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Campo de E-mail
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
                      prefixIcon: Icon(Icons.email, color: Color(0xFF212121)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu e-mail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Campo de Senha
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
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF212121)),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return 'A senha deve ter ao menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  SizedBox(height: 20),

                  Container(
                    width: double
                        .infinity, // Isso faz o botão ocupar a largura completa disponível
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação ao pressionar o botão
                        Navigator.pushNamed(
                          context,
                          '/products',
                          arguments: emailController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC38D4C),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
