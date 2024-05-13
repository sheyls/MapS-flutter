import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    // Navigation or login logic goes here
    print("Login attempt with email: ${_emailController.text}");
    Navigator.of(context).pushReplacementNamed('/map');
  }
    //bool loginSuccess = await _checkCredentials(_emailController.text, _passwordController.text);
    //if (loginSuccess) {
    //  Navigator.of(context).pushReplacementNamed('/map');
    //} else {
    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed')));
    //}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Set the background color
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png', // Path to your image
              fit: BoxFit.contain,
              height: 32, // Set an appropriate size for the logo
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('MapS'),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email, color: Colors.green),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: Colors.green),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.green), // Updated property
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}