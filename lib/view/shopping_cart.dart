import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> cartItems =
        ModalRoute.of(context)?.settings.arguments as List<String>? ?? [];
    final String customerName =
        "Cliente"; // Altere para obter o nome do cliente dinamicamente, se necessário

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Itens no Carrinho',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhum item no carrinho.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(cartItems[index]),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                cartItems.removeAt(index);
                                Navigator.pushReplacementNamed(
                                    context, '/shopping_cart',
                                    arguments: cartItems);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  cartItems.clear(); // Limpa o carrinho
                  Navigator.pop(context); // Retorna à tela inicial de produtos
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Compra finalizada para $customerName.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Finalizar Compra'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
