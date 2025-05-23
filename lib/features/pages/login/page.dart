import 'package:absen/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../home/main_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController =
  TextEditingController();
  final TextEditingController passwordController =
  TextEditingController();

  @override
  void initState() {
    usernameController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                width: 150,
                height: 150,
                'assets/images/idbc_logo.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: usernameController,
                label: 'Email or Username',
                hintText: 'Masukkan email atau Username',
                onChanged: (value) {},
                prefixIcon: Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                hintText: 'masukkan Password',
                obscureText: true,
                prefixIcon: Icon(Icons.password),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Button(
                disable: !(isValid),
                onPressed: () {
                  // Handle login action
                  context.pushReplacement(
                      const MainPage());
                },
                label: "Masuk",
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isValid {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}