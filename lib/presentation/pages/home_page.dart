import 'dart:developer';

import 'package:fic_bloc2/bloc/products/products_bloc.dart';
import 'package:fic_bloc2/presentation/pages/add_product_page.dart';
import 'package:fic_bloc2/presentation/widgets/home_page/logout_button.dart';
import 'package:fic_bloc2/presentation/widgets/home_page/products_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  void scrollPosition() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<ProductsBloc>().add(LoadMoreProductsEvent());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
    scrollPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Home Page'),
        actions: const [
          LogoutButton(),
          SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsLoaded) {
              log('Total Data: ${state.data.length}');
              // final products = state.data.reversed.toList();
              final products = state.data;
              return RefreshIndicator(
                onRefresh: () async {
                  //when refresh update the view by re-execuTE GetProductEvent
                  context.read<ProductsBloc>().add(GetProductsEvent());
                },
                child: ProductsListView(
                  isNext: state.isNext,
                  products: products,
                  controller: scrollController,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddProductPage()),
        ),
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
