import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/google_signin_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo or icon
                const Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Colors.blue,
                ),
                
                const SizedBox(height: 40),
                
                // Welcome text
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                const Text(
                  'Sign in to continue to the app',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 40),
                
                // Google Sign-in button
                GoogleSignInButton(
                  onPressed: () async {
                    final success = await authProvider.signInWithGoogle();
                    if (success && context.mounted) {
                      // Navigate to home page on successful login
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  },
                  isLoading: authProvider.isLoading,
                ),
                
                const SizedBox(height: 24),
                
                // Display error if any
                if (authProvider.error != null)
                  Text(
                    authProvider.error!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 