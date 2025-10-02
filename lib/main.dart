import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muud_health/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muud_health/auth/login_screen.dart';
import 'package:muud_health/home/homeScreen.dart';
import 'package:muud_health/bloc/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token != null ? const HomeScreen() : const SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialScreen(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator())));
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthBloc()),
          ],
          child: MaterialApp(
            title: 'MUuD',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: snapshot.data!,
          ),
        );
      },
    );
  }
}
