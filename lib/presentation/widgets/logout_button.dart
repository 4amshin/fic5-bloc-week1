import 'package:fic_bloc2/data/data_sources/local_datasources.dart';
import 'package:fic_bloc2/presentation/login_page.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await LocalDataSources().deleteToken();
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
