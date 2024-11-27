import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

class FirebaseAuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Conexão com a stream
  Stream<UserModel?> get userId {
    return _firebaseAuth.authStateChanges().map(
          (event) => _userFromFirebaseUser(event),
        );
  }

  // Pega um objeto do firebase e transforma no UserModel
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            user.uid) // Aqui você cria um UserModel com o uid do Firebase
        : null;
  }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print("Erro ao logar com email e senha: ${e.message}");
      return null;
    } catch (e) {
      print("Erro inesperado: $e");
      return null;
    }
  }

  // Método para criar um usuário com nome, email e senha
  Future<UserModel?> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload(); // Garante que a alteração seja refletida
      }

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print("Erro ao criar usuário: ${e.message}");
      return null;
    } catch (e) {
      print("Erro inesperado: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Erro ao fazer logout: $e");
    }
  }
}
