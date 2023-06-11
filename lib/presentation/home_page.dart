import 'package:fic_bloc2/bloc/products/products_bloc.dart';
import 'package:fic_bloc2/presentation/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
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
            if (state is ProductsLoaded) {
              final products = state.data;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final data = products[index];
                  return Card(
                    elevation: 0,
                    color: Colors.deepPurple[50],
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
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
                        backgroundImage: NetworkImage(data.images?[0] ??
                            'https://tinyurl.com/default-fic'),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
