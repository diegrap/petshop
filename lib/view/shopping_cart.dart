import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém os itens do carrinho, que agora é um mapa com os produtos e suas quantidades
    final Map<String, int> cartItems =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>? ?? {};
    final String customerName = "Cliente";

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
                        // Lista de produtos no carrinho com a quantidade
                        String product = cartItems.keys.toList()[index];
                        int quantity = cartItems[product]!;
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text('$product'),
                            subtitle: Text('Quantidade: $quantity'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                cartItems.remove(product);
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
