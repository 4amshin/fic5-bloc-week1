import 'dart:convert';

import 'package:dartz/dartz.dart';
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
        // List<ProductResponseModel>.from(jsonDecode(response.body)
        //     .map((e) => ProductResponseModel.fromMap(e))),
      );
    } else {
      return const Left('Failed Fetching Products');
    }
  }
}
