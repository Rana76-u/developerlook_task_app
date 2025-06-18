import 'package:developerlook_task_app/Screens%20&%20Features/Authentication/Data/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Icon(
                Icons.flight_takeoff_rounded,
                color: Colors.blueAccent,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to Airline Review',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Share and explore real airline experiences',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),

              TextButton(
                onPressed: () {
                  final messenger = ScaffoldMessenger.of(context);
                  final GoRouter router = GoRouter.of(context);

                  AuthService.instance.signInWithGoogle().then((user) {
                    if (user != null) {
                      router.go('/');
                    } else {
                      messenger.showSnackBar(
                        SnackBar(content: Text('Sign in failed. Please try again.')),
                      );
                    }
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login, color: Colors.red), // Replace with a Google logo if needed
                    const SizedBox(width: 8),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Text(
                'By signing in, you agree to our Terms & Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}