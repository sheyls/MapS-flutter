import 'package:flutter/material.dart';
import 'package:MapS/views/login_screen.dart';  
import 'package:MapS/views/map_screen.dart';  

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapS',
      theme: ThemeData(
        primarySwatch: Colors.green, 
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      home: LoginScreen(),  
      routes: {
        '/login': (context) => LoginScreen(),
        '/map': (context) => MapScreen(),  
      },
    );
  }
}
