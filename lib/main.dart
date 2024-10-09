import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petshop_final/bloc/manage_bloc.dart';
import 'view/registerpage.dart'; // Página de registro
import 'view/loginpage.dart'; // Página de login
import 'view/products.dart'; // Página de produtos
import 'view/shopping_cart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCCJxCugr4lYcZuu3wCd6_-7x248cjBdDc",
      authDomain: "petshop-a6de8.firebaseapp.com",
      projectId: "petshop-a6de8",
      storageBucket: "petshop-a6de8.appspot.com",
      messagingSenderId: "893258695402",
      appId: "1:893258695402:web:425a80972d8e1b128c4d93",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ManageBloc(InsertState(registerList: [])),
        ),
        // Adicione outros BlocProviders aqui se necessário
      ],
      child: MaterialApp(
        title: 'PetData',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Urbanist',
        ),
        home: MyHomePage(),
        routes: {
          '/user_profile': (context) =>
              UserProfile(), // Página de perfil do usuário
          '/shopping_cart': (context) =>
              ShoppingCartPage(), // Página do carrinho
          '/register': (context) => BlocProvider.value(
                value: BlocProvider.of<ManageBloc>(context),
                child: RegisterPage(), // Envolve RegisterPage com BlocProvider
              ),
          '/products': (context) => Products(),
          '/login': (context) => LoginPage(), // Adiciona rota para LoginPage
          '/shopping_cart': (context) =>
              ShoppingCartPage(), // Adiciona rota para ShoppingCartPage
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          padding: EdgeInsets.fromLTRB(23, 0, 23, 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 50.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 2, 5, 1),
                            width: 18,
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 1, 5.7, 1),
                            width: 15.3,
                            height: 11,
                          ),
                          Container(
                            width: 27,
                            height: 13,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 14.5, 15.3),
                child: Text(
                  'PetData',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    height: 1.2,
                    color: Color(0xFFC38D4C),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1, bottom: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15.5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/dog_2.png'),
                        ),
                      ),
                      width: 170,
                      height: 190,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(14.5, 0, 14.5, 15.3),
                      child: Text(
                        'Vamos começar',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          height: 1.2,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 40.3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 34),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFC38D4C),
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: Image.asset(
                                          'assets/images/facebook_logo.png',
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Continuar com o Facebook',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          height: 1.0,
                                          letterSpacing: 0.2,
                                          color: Color(0xFF212121),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFC38D4C),
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: Image.asset(
                                          'assets/images/google_logo.png',
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Continuar com o Google',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          height: 1.0,
                                          letterSpacing: 0.2,
                                          color: Color(0xFF212121),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFC38D4C),
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        child: Image.asset(
                                          'assets/images/apple_logo.png',
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Continuar com a Apple',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          height: 1.0,
                                          letterSpacing: 0.2,
                                          color: Color(0xFF212121),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFC38D4C),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text(
                                  'Cadastre-se com o e-mail',
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
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Já tem uma conta?',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            height: 1.4,
                            letterSpacing: 0.2,
                            color: Color(0xFF212121),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Faça login',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              height: 1.4,
                              letterSpacing: 0.2,
                              color: Color(0xFFC38D4C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
