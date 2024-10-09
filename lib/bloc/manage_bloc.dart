import 'package:flutter_bloc/flutter_bloc.dart';
import '../provider/generic_crud_provider.dart';
import '../model/registeruser.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  ManageBloc(ManageState initialState) : super(initialState) {
    GenericCrudProvider.stream.listen((userId) {
      add(GetRegisterUserEvent());
    });

    on<DeleteEvent>((event, emit) {
      GenericCrudProvider.deleteRegisterUser(event.userId);
    });

    on<UpdateRequest>((event, emit) {
      if (state is UpdateState) {
        emit(UpdateState(
          userId: event.userId,
          registerList: (state as UpdateState).registerList,
        ));
      }
    });

    on<UpdateCancel>((event, emit) {
      if (state is UpdateState) {
        emit(InsertState(registerList: (state as UpdateState).registerList));
      }
    });

    on<SubmitEvent>((event, emit) {
      if (state is UpdateState) {
        GenericCrudProvider.updateRegisterUser(
            (state as UpdateState).userId, event.register);
        emit(InsertState(registerList: (state as UpdateState).registerList));
      } else if (state is InsertState) {
        GenericCrudProvider.insertRegisterUser(event.register);
      }
    });

    on<GetRegisterUserEvent>((event, emit) async {
      List<RegisterUser> registerList =
          await GenericCrudProvider.getRegisterUserList();

      if (state is UpdateState) {
        emit(UpdateState(
          userId: (state as UpdateState).userId,
          registerList: registerList,
        ));
      } else if (state is InsertState) {
        emit(InsertState(
          registerList: registerList,
        ));
      }
    });

    on<LoginUser>((event, emit) async {
      try {
        RegisterUser user =
            await GenericCrudProvider.loginUser(event.email, event.senha);

        if (user.userId.isEmpty) {
          emit(AuthError(message: "Usuário não cadastrado"));
        } else {
          print("Login bem-sucedido: ${user.email}");
        }
      } catch (e) {
        emit(AuthError(message: "Erro de login: $e"));
      }
    });
  }
}

// Eventos
abstract class ManageEvent {}

class SubmitEvent extends ManageEvent {
  RegisterUser register;
  SubmitEvent({required this.register});
}

class DeleteEvent extends ManageEvent {
  String userId;
  DeleteEvent({required this.userId});
}

class GetRegisterUserEvent extends ManageEvent {}

class UpdateRequest extends ManageEvent {
  String userId;
  UpdateRequest({required this.userId});
}

class UpdateCancel extends ManageEvent {}

class LoginUser extends ManageEvent {
  final String email;
  final String senha;
  LoginUser({required this.email, required this.senha});
}

// Estados
abstract class ManageState {}

class InsertState extends ManageState {
  List<RegisterUser> registerList;
  InsertState({required this.registerList});
}

class UpdateState extends ManageState {
  String userId;
  List<RegisterUser> registerList;
  UpdateState({required this.userId, required this.registerList});
}

class Authenticated extends ManageState {
  final RegisterUser userModel;
  Authenticated({required this.userModel});
}

class AuthError extends ManageState {
  final String message;
  AuthError({required this.message});
}
