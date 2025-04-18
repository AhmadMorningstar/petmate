import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:petmate/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:petmate/pages/admin.dart'; // Assuming you have an admin page

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController(); // only used for sign-up
  final _passwordController = TextEditingController();
  final _supabase = Supabase.instance.client;

  bool _isLogin = true;

  // Function to save username to SharedPreferences
  Future<void> _saveUsernameToPrefs(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username); // Store username
  }

  Future<void> _auth() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      if (_isLogin) {
        // Login with username + password for regular users
        final response = await _supabase
            .from('users')
            .select()
            .eq('username', username)
            .eq('password', password)
            .maybeSingle();

        // LOGIN success for regular users
        if (response != null) {
          // Save username after successful login
          await _saveUsernameToPrefs(username);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );

          await Future.delayed(const Duration(seconds: 2)); // Reduced delay

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()), // Navigate to home
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid username or password')),
          );
        }
      } else {
        // Sign Up with username + email + password
        final insertResponse = await _supabase.from('users').insert({
          'username': username,
          'email': email,
          'password': password,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-up successful! Please log in.')),
        );

        setState(() {
          _isLogin = true;
          _usernameController.clear();
          _emailController.clear();
          _passwordController.clear();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _adminSignIn() async {
    final adminUsername = _usernameController.text; // Use the same username field
    final adminPassword = _passwordController.text; // Use the same password field

    try {
      final response = await _supabase
          .from('admin_users')
          .select()
          .eq('username', adminUsername)
          .eq('password', adminPassword)
          .maybeSingle();

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Admin login successful!')),
        );

        await Future.delayed(const Duration(seconds: 2)); // Reduced delay

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminScreen()), // Navigate to admin screen
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid admin credentials')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during admin login: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            if (!_isLogin)
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _auth,
              child: Text(_isLogin ? 'Login' : 'Sign Up'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin
                  ? 'Don\'t have an account? Sign up'
                  : 'Already have an account? Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _adminSignIn,
              child: const Text('Sign in as Admin'),
            ),
          ],
        ),
      ),
    );
  }
}