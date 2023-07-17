import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user/user_class.dart';
import '../main.dart';
import '../webservices/user/user_webservices.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginUser() async {
    final user = User.loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    try {
      final loggedInUser = await UserWebServices.loginUser(user);
      // Connexion réussie, naviguer vers la page principale
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => MyNavigationWidget(user: loggedInUser),
      //   ),
      // );
    } catch (error) {
      // Gérer les erreurs de connexion
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur de connexion'),
          content: const Text('Échec de la connexion. Veuillez vérifier vos informations.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _loginUser,
              child: Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
