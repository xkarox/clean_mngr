import 'package:clean_mngr/widgets/home/quick_menu/quick_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Home',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 226, 226, 226)
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withAlpha(1500),
            Theme.of(context).colorScheme.primary.withAlpha(1500),
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: const SafeArea(
          child: Column(
            children: [
              SizedBox(height: 0),
              QuickMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
