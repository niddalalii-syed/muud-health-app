import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muud_health/auth/login_screen.dart';
import 'package:muud_health/home/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // splash delay
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (context.mounted) {
      if (token != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         backgroundColor: const Color(0xFFF2F2F7),
      // Color(0xFF7E22CE),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png',),
            SizedBox(height: 40,),
            CircularProgressIndicator(color: Color(0xFF7E22CE),)
            // Text(
            //   'MUUD',
            //   style: TextStyle(
            //     fontSize: 40,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //     letterSpacing: 2,
            //   ),
            // ),
          ],
        ),
        // Or replace with: Image.asset('assets/logo.png', height: 100)
      ),
    );
  }
}
