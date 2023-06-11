import 'package:dartz/dartz.dart';
import 'package:fic_bloc2/data/models/request/login_request_model.dart';
import 'package:fic_bloc2/data/models/request/register_request_model.dart';
import 'package:fic_bloc2/data/models/response/login_response_model.dart';
import 'package:fic_bloc2/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthDataSources {
  Future<Either<String, RegisterResponseModel>> register(
    RegisterRequestModel model,
  ) async {
    String baseUrl = 'https://api.escuelajs.co/api/v1/users/';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromJson(response.body));
    } else {
      return const Left('Register Failed');
    }
  }

  Future<Either<String, LoginResponseModel>> login(
    LoginRequestModel model,
  ) async {
    String baseUrl = 'https://api.escuelajs.co/api/v1/auth/login';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return const Left('Login Failed');
    }
  }
}
