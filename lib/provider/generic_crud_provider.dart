import 'dart:async';
import '../model/registeruser.dart';

class GenericCrudProvider {
  // Mapa para armazenar os registros de usuário
  static Map<String, RegisterUser> database = {};
  static int numInsertions = 0;

  // Controlador para transmitir atualizações
  static final _controller = StreamController<String>.broadcast();

  // Getter para acessar o stream
  static Stream<String> get stream => _controller.stream;

  // Métodos para CRUD de registros de usuário
  static Future<RegisterUser?> getRegisterUser(String userId) async {
    return database[userId];
  }

  static Future<String> insertRegisterUser(RegisterUser register) async {
    String key = numInsertions.toString();
    register.userId = key;
    database[key] = register;
    numInsertions++;
    _controller.sink.add(key);

    print("Usuário registrado: ${register.toMap()}"); // Verifique os dados aqui
    return key;
  }

  static Future<String> updateRegisterUser(
      String userId, RegisterUser register) async {
    if (database.containsKey(userId)) {
      register.userId = userId;
      database[userId] = register;
      _controller.sink.add(userId);
      return userId;
    } else {
      throw Exception("User not found");
    }
  }

  static Future<String> deleteRegisterUser(String userId) async {
    if (database.containsKey(userId)) {
      database.remove(userId);
      _controller.sink.add(userId);
      return userId;
    } else {
      throw Exception("User not found");
    }
  }

  static Future<List<RegisterUser>> getRegisterUserList() async {
    return database.values.toList();
  }

  // Método de login de usuário
  static Future<RegisterUser?> loginUser(String email, String senha) async {
    print(
        "Tentando fazer login com o email: $email e senha: $senha"); // Verifique os dados recebidos

    try {
      var user = database.values.firstWhere(
        (user) => user.email == email && user.senha == senha,
        orElse: () => throw Exception("Credenciais inválidas"),
      );

      print(
          "Usuário encontrado: ${user.toMap()}"); // Verifique os dados do usuário encontrado
      return user;
    } catch (e) {
      print("Erro ao tentar encontrar o usuário: $e"); // Log de erro
      throw Exception("Credenciais inválidas");
    }
  }

  // Fechar o stream quando não for mais necessário
  static void dispose() {
    _controller.close();
  }
}
