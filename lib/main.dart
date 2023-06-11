import 'package:fic_bloc2/bloc/login/login_bloc.dart';
import 'package:fic_bloc2/bloc/products/products_bloc.dart';
import 'package:fic_bloc2/bloc/register/register_bloc.dart';
import 'package:fic_bloc2/data/data_sources/auth_datasources.dart';
import 'package:fic_bloc2/data/data_sources/product_datasoruces.dart';
import 'package:fic_bloc2/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthDataSources()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDataSources()),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(ProductDataSources()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
