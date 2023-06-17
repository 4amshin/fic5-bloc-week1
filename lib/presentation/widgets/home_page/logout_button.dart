import 'package:fic_bloc2/bloc/products/products_bloc.dart';
import 'package:fic_bloc2/data/data_sources/local_datasources.dart';
import 'package:fic_bloc2/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        //delete the login token in local
        await LocalDataSources().deleteToken();
        //clear the Product State
        context.read<ProductsBloc>().add(ClearProductsEvent());
        //Navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      icon: const Icon(
        Icons.logout,
        size: 20,
      ),
    );
  }
}
