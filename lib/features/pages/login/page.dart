import 'package:absen/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../home/main_page.dart';
import 'provider/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Auto focus username field when page loads
    Future.microtask(() => usernameFocus.requestFocus());
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.contains('@')) {
      // Check if it's an email
      final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegExp.hasMatch(value)) {
        return 'Email tidak valid';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, provider, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    50,
                    20,
                    MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/idbc_logo.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 30),
                        if (provider.error != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red.shade700,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    provider.error!,
                                    style: TextStyle(
                                      color: Colors.red.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: usernameController,
                          focusNode: usernameFocus,
                          label: 'Email or Username',
                          hintText: 'Masukkan email atau Username',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => provider.resetError(),
                          onFieldSubmitted: (_) => passwordFocus.requestFocus(),
                          validator: _validateEmail,
                          prefixIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: passwordController,
                          focusNode: passwordFocus,
                          label: 'Password',
                          hintText: 'Masukkan Password',
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) => provider.resetError(),
                          onFieldSubmitted: (_) => _handleLogin(provider),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed:
                                () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged:
                                  (value) => setState(
                                    () => _rememberMe = value ?? false,
                                  ),
                            ),
                            const Text('Ingat Saya'),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // TODO: Implement forgot password
                              },
                              child: const Text('Lupa Password?'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Button(
                          disable: !isValid || provider.isLoading,
                          onPressed: () => _handleLogin(provider),
                          label: provider.isLoading ? "Loading..." : "Masuk",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (provider.isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _handleLogin(LoginProvider provider) async {
    if (!formKey.currentState!.validate()) return;

    // Hide keyboard
    FocusScope.of(context).unfocus();

    final success = await provider.login(
      usernameController.text,
      passwordController.text,
    );

    if (success && mounted) {
      // TODO: If remember me is checked, save credentials securely
      if (_rememberMe) {
        // Implement secure credential storage
      }
      context.pushReplacement(const MainPage());
    }
  }

  bool get isValid {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}