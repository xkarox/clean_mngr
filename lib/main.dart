import 'package:clean_mngr/screens/auth.dart';
import 'package:clean_mngr/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

final firebaseAuth = FirebaseAuth.instance;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _isLoggedIn = false;
  @override
  Widget build(BuildContext context) {

    firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          _isLoggedIn = true;
        });
      } else {
        setState(() {
          _isLoggedIn = false;
        });
      }
    });

    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: _isLoggedIn ? const HomeScreen() : const AuthScreen(),
    );
  }
}
