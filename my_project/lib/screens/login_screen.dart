import 'package:flutter/material.dart';
import '../services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final PocketbaseService pbService = PocketbaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = await pbService.login(
                  _emailController.text,
                  _passwordController.text,
                );

                if (user != null) {
                  final role = user.data['role'];

                  if (role == 'admin') {
                    Navigator.pushReplacementNamed(context, '/edit');
                  } else {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                } else {
                  print('Login failed');
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Don\'t have an account? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}


