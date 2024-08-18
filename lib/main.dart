import 'package:clean_mngr/screens/auth.dart';
import 'package:clean_mngr/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color primarySeedColor = Color.fromARGB(255, 62, 0, 107);

// Make a light ColorScheme from the seeds.
final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  // Primary key color is required, like seed color in ColorScheme.fromSeed.
  primaryKey: primarySeedColor,
  // Tone chroma config and tone mapping is optional, if you do not add it
  // you get the config matching Flutter's Material 3 ColorScheme.fromSeed.
  tones: FlexTones.vivid(Brightness.light),
);

// Make a dark ColorScheme from the same seed colors.
final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: primarySeedColor,
  tones: FlexTones.vivid(Brightness.dark),
);
    
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ),
);
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
      themeMode: ThemeMode.system,
      theme: ThemeData(colorScheme: schemeLight),
      darkTheme: ThemeData(colorScheme: schemeDark),
      home: _isLoggedIn ? const HomeScreen() : const AuthScreen(),
    );
  }
}
