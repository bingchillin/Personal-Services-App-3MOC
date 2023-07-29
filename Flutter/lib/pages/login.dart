import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user/user_webservices.dart';
import 'package:goldie_studio/widgets/title.dart';
import '../main.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final loggedInUser = await UserWebServices.loginUser(email, password);

      if (loggedInUser.role != 1) {
        // Le rôle n'est pas autorisé, afficher un message d'erreur
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur de connexion'),
            content:
                const Text('Vous n\'êtes pas autorisé à accéder à cette page.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Connexion réussie, naviguer vers la page principale
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyNavigationWidget(),
          ),
        );
      }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://cdn.discordapp.com/attachments/809752735154962473/1134947717605499021/logo.png',
                  width: 75,
                  height: 75,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TitleWidget(title: "Goldie STUDIO"),
                      const SizedBox(height: 50),
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
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: _loginUser,
                        child: const Text('Connexion'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
