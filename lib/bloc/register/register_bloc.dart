import 'package:fic_bloc2/data/data_sources/auth_datasources.dart';
import 'package:fic_bloc2/data/models/request/register_request_model.dart';
import 'package:fic_bloc2/data/models/response/register_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDataSources dataSources;
  RegisterBloc(this.dataSources) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
  }

  void _doRegister(
    DoRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    //send register request model -> data source, & wait the response
    final result = await dataSources.register(event.model);
    result.fold(
      (error) {
        emit(RegisterError(message: error));
      },
      (data) {
        emit(RegisterLoaded(model: data));
      },
    );
  }
}
