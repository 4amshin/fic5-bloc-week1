import 'package:bloc/bloc.dart';
import 'package:fic_bloc2/data/data_sources/auth_datasources.dart';
import 'package:fic_bloc2/data/models/request/login_request_model.dart';
import 'package:fic_bloc2/data/models/response/login_response_model.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDataSources dataSources;
  LoginBloc(this.dataSources) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
  }
  Future<void> _doLogin(
    DoLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await dataSources.login(event.model);
    result.fold(
      (error) => emit(LoginError(message: error)),
      (data) {
        emit(LoginLoaded(model: data));
      },
    );
  }
}
