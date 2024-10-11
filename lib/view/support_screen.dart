import 'package:flutter/material.dart';
import 'package:petshop_final/provider/sheets_provider.dart';
import 'support_screen_response.dart';

class Tela3 extends StatefulWidget {
  @override
  _Tela3State createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {
  final _formKey = GlobalKey<FormState>(); // Chave global do formulário
  String _name = '';
  String _email = '';
  String _message = '';
  bool _termsAccepted = false;
  String? _selectedOption;
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fale Conosco'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Campo para Nome
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 16),
              // Campo para Email
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16),
              // Campo para Mensagem
              TextFormField(
                decoration: InputDecoration(labelText: 'Mensagem'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua mensagem';
                  }
                  return null;
                },
                onSaved: (value) {
                  _message = value!;
                },
              ),
              SizedBox(height: 16),
              // Checkbox para aceitar termos e condições
              CheckboxListTile(
                title: Text('Aceito os termos e condições'),
                value: _termsAccepted,
                onChanged: (bool? value) {
                  setState(() {
                    _termsAccepted = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              // RadioButtons para selecionar opções exclusivas
              Text('Selecione a natureza do contato:'),
              ListTile(
                title: const Text('Consulta'),
                leading: Radio<String>(
                  value: 'Opção 1',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Reclamação'),
                leading: Radio<String>(
                  value: 'Opção 2',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              // Dropdown para selecionar uma categoria
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Categoria da mensagem'),
                value: _selectedCategory,
                items: <String>['Suporte', 'Financeiro', 'Comercial']
                    .map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione uma categoria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Botão de envio
              ElevatedButton(
                onPressed: () {
                  Color(0xFFC38D4C);
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Coletar dados e enviar
                    List<String> dataToSend = [
                      _name,
                      _email,
                      _message,
                      _termsAccepted.toString(),
                      _selectedOption ?? '',
                      _selectedCategory ?? ''
                    ];
                    Future<String?> futureResult =
                        SheetsDatabase.helper.submitData(dataToSend);
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.grey[900], // Fundo da BottomSheet
                          child: FeedbackScreen(futureResult: futureResult),
                        );
                      },
                    );
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
