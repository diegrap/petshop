import 'package:flutter/material.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  // Controladores para os campos de edição
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petGenderController = TextEditingController();
  final TextEditingController _petBirthdateController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();
  final TextEditingController _vaccinesController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Color(0xFFC38D4C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campos de edição do perfil do usuário
            _buildTextField("Nome do Usuário", _nameController),
            _buildTextField("Bio", _bioController),
            SizedBox(height: 30),

            // Campos de edição do perfil do pet
            Text(
              "Informações do Pet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTextField("Nome do Pet", _petNameController),
            _buildTextField("Raça do Pet", _petBreedController),
            _buildTextField("Gênero do Pet", _petGenderController),
            _buildTextField("Data de Nascimento", _petBirthdateController),
            _buildTextField("Medicamentos", _medicationsController),
            _buildTextField("Vacinas", _vaccinesController),
            _buildTextField("Alergias", _allergiesController),
            SizedBox(height: 30),

            // Botão para salvar as alterações
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/user_profile');
              },
              icon: Icon(Icons.save),
              label: Text("Salvar Alterações"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC38D4C), // Cor do botão
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para criar os campos de texto
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, color: Color(0xFFC38D4C)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFC38D4C)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC38D4C)),
          ),
        ),
      ),
    );
  }
}
