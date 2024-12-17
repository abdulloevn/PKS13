import 'package:flutter/material.dart';
import 'package:pks_sem5_p8/models/auth_service.dart';
import 'package:pks_sem5_p8/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      await authService.login(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Ошибка: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Профиль"),
        ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(label: Text("Эл. почта")),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(label: Text("Пароль")),
            obscureText: true,
          ),
          const SizedBox(height: 15,),
          ElevatedButton(onPressed: () {
            login();
          }, child: const Text("Войти")),
          const SizedBox(height: 20,),
          TextButton(onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
          }, style: TextButton.styleFrom(foregroundColor: Colors.deepPurple[100]), child: const Text("Нет аккаунта?"),)
        ],
      ),
    );
  }
}
