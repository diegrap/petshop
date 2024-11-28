import 'package:flutter/material.dart';
import 'package:petshop_final/view/user_profile.dart';
import 'package:petshop_final/view/products.dart';

class Alimenticio extends StatefulWidget {
  final Map<String, int> cartItems = {}; // Mapeia os itens com quantidade

  @override
  _AlimenticioState createState() => _AlimenticioState();
}

class _AlimenticioState extends State<Alimenticio> {
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Products()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserProfile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione o produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/shopping_cart',
                  arguments: widget.cartItems);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                  'Selecione o produto',
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
              title: 'Ração',
              description: '5kg - RS28,00',
              imageUrl: 'assets/images/racao.jpg',
              onTap: () {
                _addToCart(context, 'Ração');
              },
            ),
            SizedBox(height: 16),
            CategoryCard(
              title: 'Biscoito',
              description: '500g - RS10,00',
              imageUrl: 'assets/images/biscoito.jpg',
              onTap: () {
                _addToCart(context, 'Biscoito');
              },
            ),
            SizedBox(height: 16),
            CategoryCard(
              title: 'Sachê',
              description: '100g - RS5,50',
              imageUrl: 'assets/images/sache.jpg',
              onTap: () {
                _addToCart(context, 'Sachê');
              },
            ),
            SizedBox(height: 16),
            CategoryCard(
              title: 'Patê',
              description: '100g - RS6,00',
              imageUrl: 'assets/images/pate.jpg',
              onTap: () {
                _addToCart(context, 'Patê');
              },
            ),
            SizedBox(height: 16),
            CategoryCard(
              title: 'Stick',
              description: '500g - RS20,00',
              imageUrl: 'assets/images/sticks.jpg',
              onTap: () {
                _addToCart(context, 'Stick');
              },
            ),
          ],
        ),
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
            label: 'Suporte',
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

  void _addToCart(BuildContext context, String productName) {
    // Verifica se o produto já está no carrinho
    if (widget.cartItems.containsKey(productName)) {
      // Se o produto já estiver no carrinho, incrementa a quantidade
      widget.cartItems[productName] = widget.cartItems[productName]! + 1;
    } else {
      // Caso contrário, adiciona o produto com quantidade 1
      widget.cartItems[productName] = 1;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Produto $productName adicionado ao carrinho.'),
        duration: Duration(seconds: 2),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: onTap,
                        ),
                      ],
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
