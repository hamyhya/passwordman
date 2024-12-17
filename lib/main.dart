import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Password Manager',
theme: ThemeData(primarySwatch:
Colors.blue),
initialRoute: '/',
routes: {
'/': (context) => LoginScreen(),
},
);
}
}