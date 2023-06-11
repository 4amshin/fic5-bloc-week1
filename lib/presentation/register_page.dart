import 'package:fic_bloc2/bloc/register/register_bloc.dart';
import 'package:fic_bloc2/data/models/request/register_request_model.dart';
import 'package:fic_bloc2/presentation/login_page.dart';
import 'package:fic_bloc2/presentation/widgets/fic_button.dart';
import 'package:fic_bloc2/presentation/widgets/page_title.dart';
import 'package:fic_bloc2/presentation/widgets/text_input.dart';
import 'package:fic_bloc2/presentation/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
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
            const PageTitle(text: 'Register'),
            TextInput(
              label: 'Name',
              controller: nameController,
            ),
            TextInput(
              label: 'Email',
              controller: emailController,
            ),
            TextInput(
              label: 'Password',
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 25.0),
            BlocConsumer<RegisterBloc, RegisterState>(
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return FicButton(
                  label: 'Register',
                  onTap: () {
                    final requestModel = RegisterRequestModel(
                      name: nameController!.text,
                      email: emailController!.text,
                      password: passwordController!.text,
                    );
                    context
                        .read<RegisterBloc>()
                        .add(DoRegisterEvent(model: requestModel));
                  },
                );
              },
              listener: (context, state) {
                /*<<REGISTER FAILED>>*/
                if (state is RegisterError) {
                  //display snackbar error when login failed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }

                /*<<REGISTER SUCCESS>>*/
                if (state is RegisterLoaded) {
                  //display snackbar when login success
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("Request success with id: ${state.model.id}"),
                      backgroundColor: Colors.indigoAccent,
                    ),
                  );

                  //navigate to login page when register success
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
            ),
            const SizedBox(height: 15),
            const TextLink(
              text: 'Sudah Punya Akun? Login',
              navigateTo: LoginPage(),
            ),
          ],
        ),
      ),
    );
  }
}
