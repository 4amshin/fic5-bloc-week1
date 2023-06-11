import 'dart:developer';

import 'package:fic_bloc2/bloc/login/login_bloc.dart';
import 'package:fic_bloc2/data/data_sources/local_datasources.dart';
import 'package:fic_bloc2/data/models/request/login_request_model.dart';
import 'package:fic_bloc2/presentation/home_page.dart';
import 'package:fic_bloc2/presentation/register_page.dart';
import 'package:fic_bloc2/presentation/widgets/fic_button.dart';
import 'package:fic_bloc2/presentation/widgets/page_title.dart';
import 'package:fic_bloc2/presentation/widgets/text_input.dart';
import 'package:fic_bloc2/presentation/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    checkAuth();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  void checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    final auth = await LocalDataSources().getToken();
    if (auth.isNotEmpty) {
      log("Login Token is Exist, Navigate to HomePage");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      log("Token is Empty");
    }
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const PageTitle(text: 'Login'),
            TextInput(
              label: 'Email',
              controller: emailController,
            ),
            TextInput(
              label: 'Password',
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 25),
            BlocConsumer<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return FicButton(
                  label: 'Login',
                  onTap: () {
                    final requestModel = LoginRequestModel(
                      email: emailController!.text,
                      password: passwordController!.text,
                    );
                    context
                        .read<LoginBloc>()
                        .add(DoLoginEvent(model: requestModel));
                  },
                );
              },
              listener: (context, state) {
                /*<<LOGIN FAILED>>*/
                if (state is LoginError) {
                  //display snackbar error when login failed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }

                /*<<LOGIN SUCCESS>>*/
                if (state is LoginLoaded) {
                  //save token in local when login is success
                  LocalDataSources().saveToken(state.model.accessToken);

                  //display snackbar if login success
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login Success"),
                      backgroundColor: Colors.indigoAccent,
                    ),
                  );

                  //navigate to the HomePage when login success
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              },
            ),
            const SizedBox(height: 15),
            const TextLink(
              text: 'Belum Punya Akun? Register',
              navigateTo: RegisterPage(),
            ),
          ],
        ),
      ),
    );
  }
}
