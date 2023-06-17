// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic_bloc2/presentation/pages/add_product_page.dart';
import 'package:flutter/material.dart';

import 'package:fic_bloc2/data/models/response/product_response_model.dart';

class ProductsListView extends StatelessWidget {
  final List<ProductResponseModel> products;
  final ScrollController? controller;
  final bool isNext;
  const ProductsListView({
    Key? key,
    required this.products,
    this.controller,
    required this.isNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // reverse: true,
      controller: controller,
      physics: const BouncingScrollPhysics(),
      itemCount: isNext ? products.length + 1 : products.length,
      itemBuilder: (context, index) {
        if (isNext && index == products.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final data = products[index];
        return Card(
          elevation: 0,
          color: Colors.deepPurple[50],
          margin: const EdgeInsets.only(bottom: 15),
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProductPage(
                  isEdit: true,
                  product: data,
                ),
              ),
            ),
            title: Text(
              data.title ?? 'title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              data.description ?? 'content',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            trailing: CircleAvatar(
              backgroundImage: NetworkImage(
                  data.images?[0] ?? 'https://tinyurl.com/default-fic'),
            ),
          ),
        );
      },
    );
  }
}
