class RegisterUser {
  String nome;
  String email;
  String senha;
  String userId;

  // Construtor principal
  RegisterUser({
    required this.userId,
    this.nome = "",
    this.email = "",
    this.senha = "",
  });

  // Construtor para inicialização com dados sem userId
  RegisterUser.withData({
    this.nome = "",
    this.email = "",
    this.senha = "",
  }) : userId = "";

  // Construtor padrão sem parâmetros
  RegisterUser.empty()
      : nome = "",
        email = "",
        senha = "",
        userId = "";

  // Construtor para converter Map para objeto
  RegisterUser.fromMap(Map<String, dynamic> map)
      : nome = map["nome"] ?? "",
        email = map["email"] ?? "",
        senha = map["senha"] ?? "",
        userId = map["userId"] ?? "";

  // Converte o objeto em Map
  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "email": email,
      "senha": senha,
      "userId": userId,
    };
  }

  // Validações opcionais
  bool isEmailValid() => email.contains('@');
  bool isPasswordValid() => senha.length >= 6;
  bool isNomeValid() => nome.isNotEmpty;

  // Sobrescreve o toString para depuração
  @override
  String toString() {
    return 'RegisterUser(userId: $userId, nome: $nome, email: $email)';
  }
}
