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

  Future<UserModel?> signInAnonymously() async {
    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    User? user = userCredential.user;

    return _userFromFirebaseUser(user);
  }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    return _userFromFirebaseUser(user);
  }

  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    return _userFromFirebaseUser(user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
