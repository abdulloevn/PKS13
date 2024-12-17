import 'package:flutter/material.dart';
import 'package:pks_sem5_p8/models/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  void register() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final name = nameController.text;
    if (password != confirmPassword) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Ошибка"),
              content: const Text("Пароли не совпадают"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ясно"))
              ],
            );
          });
      return;
    }
    try {
      AuthResponse response = await authService.register(email, password, name);
      // final user = response.user;
      // // if (user != null) {
      // //     await Supabase.instance.client.from('profiles').insert({"id": user.id, "name": name});
      // // }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Ошибка: $e")));
      }
    }
    ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Регистрация успешна! Войдите в аккаунт")));
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Регистрация"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(label: Text("Имя")),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(label: Text("Эл. почта")),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(label: Text("Пароль")),
            obscureText: true,
          ),
          TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(label: Text("Пароль (повторите)")),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              register();
            },
            child: const Text("Зарегистрироваться"),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
