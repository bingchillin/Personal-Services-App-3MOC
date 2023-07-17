import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user/user_webservices.dart';
import '../main.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await UserWebServices.loginUser(email, password);
      // Connexion réussie, naviguer vers la page principale
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyNavigationWidget(),
        ),
      );
    } catch (error) {
      // Gérer les erreurs de connexion
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur de connexion'),
          content: const Text(
              'Échec de la connexion. Veuillez vérifier vos informations.'),
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
              child: const Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
