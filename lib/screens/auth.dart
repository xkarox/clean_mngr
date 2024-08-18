import 'package:clean_mngr/widgets/auth/auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(''),
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 226, 226, 226)
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withAlpha(1500),
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: const AuthWidget(),
      ),
    );
  }
}