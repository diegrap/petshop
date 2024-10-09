import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart'; // Importe o AuthBloc correto
import 'loginpage.dart';
import 'registerpage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WrapperState();
  }
}

class WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Erro do Firebase"),
                content: Text(state.message),
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return authenticatedWidget(context);
        } else {
          return unauthenticatedWidget(context);
        }
      },
    );
  }
}

Widget authenticatedWidget(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(Logout());
        },
        child: const Icon(Icons.logout),
      ),
      appBar: AppBar(
        title: const Text("Seu Aplicativo"),
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.lock)),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Center(child: Text("Conteúdo para usuário autenticado")),
          Center(child: Text("Outro conteúdo para usuário autenticado")),
        ],
      ),
    ),
  );
}

Widget unauthenticatedWidget(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: const Text("Autenticação Necessária"),
        bottom: TabBar(
          tabs: [
            Tab(text: "Novo Cadastro"),
            Tab(text: "Efetuar Login"),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          RegisterPage(),
          LoginPage(),
        ],
      ),
    ),
  );
}
