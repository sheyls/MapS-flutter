import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final url = Uri.parse('http://192.168.33.8:8001/api/login'); 

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['status']) {
          // Guardar el token y navegar a la siguiente pantalla
          print('Login Success: ${responseData['token']}');
          Navigator.of(context).pushReplacementNamed('/map');
        } else {
          // Mostrar mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
        }
      } else {
        // Error de servidor o de red
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: ${responseData['message']}')));
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // El resto del código de tu widget no cambia
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
