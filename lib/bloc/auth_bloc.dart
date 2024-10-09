import 'package:flutter_bloc/flutter_bloc.dart';
import '../provider/firebase_auth.dart';
import '../model/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthenticationService _authenticationService =
      FirebaseAuthenticationService();

  AuthBloc() : super(Unauthenticated());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthServerEvent) {
      if (event.userModel == null) {
        yield Unauthenticated();
      } else {
        // Ajuste necessário para FirestoreDatabase
        // FirestoreDatabase.helper.uid = event.userModel!.uid;
        yield Authenticated(userModel: event.userModel!);
      }
    } else if (event is RegisterUser) {
      try {
        await _authenticationService.createUserWithEmailAndPassword(
            event.username, event.password);
      } catch (e) {
        yield AuthError(message: "Impossível Registrar: ${e.toString()}");
      }
    } else if (event is LoginUser) {
      try {
        await _authenticationService.signInWithEmailAndPassword(
            event.username, event.password);
      } catch (e) {
        yield AuthError(
            message: "Impossível Logar com ${event.username}: ${e.toString()}");
      }
    } else if (event is Logout) {
      try {
        await _authenticationService.signOut();
        yield Unauthenticated();
      } catch (e) {
        yield AuthError(message: "Impossível Efetuar Logout: ${e.toString()}");
      }
    }
  }
}

// Eventos
abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  String username;
  String password;

  RegisterUser({required this.username, required this.password});
}

class LoginUser extends AuthEvent {
  String username;
  String password;

  LoginUser({required this.username, required this.password});
}

class LoginAnonymousUser extends AuthEvent {}

class Logout extends AuthEvent {}

class AuthServerEvent extends AuthEvent {
  final UserModel? userModel;
  AuthServerEvent(this.userModel);
}

// Estados
abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserModel userModel;
  Authenticated({required this.userModel});
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
