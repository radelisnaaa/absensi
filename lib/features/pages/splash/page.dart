import 'package:absen/core/extensions/build_context_ext.dart';
import 'package:absen/features/pages/login/page.dart';
import 'package:absen/features/pages/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:absen/features/pages/login/service/auth_token_cache.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    final authCache = await AuthTokenCache.create();
    
    // Add a small delay for splash screen visibility
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      if (authCache.isLoggedIn()) {
        context.pushReplacement(const MainPage());
      } else {
        context.pushReplacement(const LoginPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Center (
                child: Image.asset(
                  width: 150,
                  height: 150,
                  'assets/images/idbc_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(height: 20),
          ],
        )
    );
  }
}