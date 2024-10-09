class RegisterUser {
  String nome;
  String email;
  String senha;
  String userId;

  RegisterUser({
    required this.userId,
    this.nome = "",
    this.email = "",
    this.senha = "",
  });

  RegisterUser.withData({
    this.nome = "",
    this.email = "",
    this.senha = "",
  }) : userId = "";

  RegisterUser.fromMap(Map<String, dynamic> map)
      : nome = map["nome"] ?? "",
        email = map["email"] ?? "",
        senha = map["senha"] ?? "",
        userId = map["userId"] ?? "";

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "email": email,
      "senha": senha,
      "userId": userId,
    };
  }
}
