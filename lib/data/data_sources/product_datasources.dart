import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic_bloc2/data/models/request/product_request_model.dart';
import 'package:fic_bloc2/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductDataSources {
  Future<Either<String, List<ProductResponseModel>>> getAllProduct() async {
    const baseUrl = 'https://api.escuelajs.co/api/v1/products/';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return Right(
        List.from(jsonDecode(response.body))
            .map((e) => ProductResponseModel.fromMap(e))
            .toList(),
      );
    } else {
      return const Left('Failed Fetching Products');
    }
  }

  Future<Either<String, List<ProductResponseModel>>> getPaginationProduct({
    required int offset,
    required int limit,
  }) async {
    const baseUrl = 'https://api.escuelajs.co/api/v1/products/';
    final response =
        await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      return Right(
        List.from(jsonDecode(response.body))
            .map((e) => ProductResponseModel.fromMap(e))
            .toList(),
      );
    } else {
      return const Left('Failed Fetching Products');
    }
  }

  // https://api.escuelajs.co/api/v1/products/?offset=0&limit=5

  Future<Either<String, ProductResponseModel>> addProduct(
      ProductRequestModel model) async {
    const baseUrl = 'https://api.escuelajs.co/api/v1/products/';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed Adding Product');
    }
  }

  Future<Either<String, ProductResponseModel>> updateProduct(
    int productId,
    ProductRequestModel model,
  ) async {
    final baseUrl = "https://api.escuelajs.co/api/v1/products/$productId";
    final response = await http.put(
      Uri.parse(baseUrl),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left("Failed Updating Data");
    }
  }
}
