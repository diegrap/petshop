import 'package:flutter/material.dart';
import 'package:petshop_final/view/products.dart';
import 'package:petshop_final/view/profile_update_screen.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Products()),
      );
    } else if (index == 1) {
      // Já está na tela de perfil
    }
  }

  void _onLogout() {
    // Ação de logout
    Navigator.pop(context); // Exemplo de sair da tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Color(0xFFC38D4C),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Ação de configurações
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Informações do Usuário no topo
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/images/user_placeholder.png'),
                ),
                SizedBox(width: 20),
                Expanded(
                  // Ajusta o conteúdo ao espaço disponível
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome do Usuário",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Limita o texto se ultrapassar o espaço
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Bio: Descrição breve do usuário",
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Informações do Pet à Esquerda e Imagem à Direita
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coluna com labels e valores à esquerda
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileField("Nome do Pet:", "Nome do Pet"),
                      _buildProfileField("Raça do Pet:", "Raça do Pet"),
                      _buildProfileField("Gênero do Pet:", "Gênero do Pet"),
                      _buildProfileField("Data de Nascimento: ", "01/01/2000"),
                      _buildProfileField(
                          "Medicamentos:", "Nome do medicamento"),
                      _buildProfileField("Vacinas:", "Nome da vacina"),
                      _buildProfileField("Alergias:", "Nome da alergia"),
                    ],
                  ),
                ),

                // Imagem do pet à direita
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/images/pet_placeholder.png'),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Botões Editar e Sair
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botão de Editar
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditUserProfile()), // Redireciona para a tela de edição
                    );
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Editar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC38D4C), // Cor laranja do botão
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(width: 20), // Espaço entre os botões
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Sair"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Cor do botão de sair
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
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

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 10), // Espaçamento entre label e valor
          Flexible(
            // Ajusta o valor ao espaço disponível
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow
                  .ellipsis, // Limita o texto se ultrapassar o espaço
            ),
          ),
        ],
      ),
    );
  }
}
