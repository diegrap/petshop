import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petshop_final/bloc/manage_bloc.dart';
import 'alimenticio.dart'; // Certifique-se de importar corretamente o widget Alimenticio
import 'package:petshop_final/view/user_profile.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // ignore: unused_field
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/shopping_cart');
            },
          ),
        ],
      ),
      body: BlocBuilder<ManageBloc, ManageState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF212121),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Compre por Categorias',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        height: 1.2,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                CategoryCard(
                  title: 'Alimentício',
                  description: 'Descrição do Alimentício',
                  imageUrl: 'assets/images/alimenticios.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Alimenticio(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                CategoryCard(
                  title: 'Acessório',
                  description: 'Descrição das Acessórios',
                  imageUrl: 'assets/images/acessorios.jpeg',
                  onTap: () {
                    // Implemente a ação desejada
                  },
                ),
                SizedBox(height: 16),
                CategoryCard(
                  title: 'Brinquedo',
                  description: 'Descrição de Brinquedo',
                  imageUrl: 'assets/images/brinquedos.png',
                  onTap: () {
                    // Implemente a ação desejada
                  },
                ),
                SizedBox(height: 16),
                CategoryCard(
                  title: 'Remédio',
                  description: 'Descrição de Remédio',
                  imageUrl: 'assets/images/remedios.png',
                  onTap: () {
                    // Implemente a ação desejada
                  },
                ),
                SizedBox(height: 16),
                CategoryCard(
                  title: 'Higiene',
                  description: 'Descrição de Higiene',
                  imageUrl: 'assets/images/higiene.jpeg',
                  onTap: () {
                    // Implemente a ação desejada
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Suporte', // Adiciona o ícone de suporte
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/products');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/user_profile');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/support');
          }
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D04060F),
              offset: Offset(0, 4),
              blurRadius: 30,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFA0A0A0)),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imageUrl),
                ),
              ),
              width: 113,
              height: 92,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.4,
                        letterSpacing: 0.2,
                        color: Color(0xFF616161),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.4,
                        letterSpacing: 0.2,
                        color: Color(0xFF616161),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
