import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muud_health/auth/signup_screen.dart';
import 'package:muud_health/bloc/auth_bloc.dart';
import 'package:muud_health/bloc/auth_event.dart';
import 'package:muud_health/bloc/auth_state.dart';
import 'package:muud_health/home/homeScreen.dart';
import 'package:muud_health/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
   backgroundColor: const Color(0xFFF2F2F7),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
            setState(() => _isLoading = true);
         if (state is AuthSuccess) {

      SnackbarHelper.show(context, 'Login successful!', backgroundColor: Colors.green);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
         setState(() => _isLoading = false);
    } else if (state is AuthFailure) {
      SnackbarHelper.show(context, state.message, backgroundColor: Colors.red);
         setState(() => _isLoading = false);
    }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Center(child: Image.asset('assets/logo.png')),
                  Center(
                    child: Text(
                      'Welcome back',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                      'Please enter your login credentials',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                    filled: true,
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: 'example@gmail.com',
                      labelText: 'Username / email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(  fillColor: Colors.white,
                    filled: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: const Icon(Icons.visibility_off),
                      hintText: '********',
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null :  () {
                        final username = _usernameController.text.trim();
                        final password = _passwordController.text.trim();
                        if (username.isEmpty || password.isEmpty) return;
                        context.read<AuthBloc>().add(
                          LoginRequested(username, password),
                        );
                       
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7E22CE),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const SignupScreen();
                            },
                          ),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(color: Color(0xFF7E22CE)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
