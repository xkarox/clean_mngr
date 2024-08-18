import 'package:clean_mngr/widgets/auth/auth_field_column.dart';
import 'package:clean_mngr/widgets/auth/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _isSubmitting = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Null validateEmail(String email) {
    var isValid = emailValidator(email);
    if (isValid != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isValid,
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
    return isValid;
  }

  Null validatePassword(String password) {
    var isValid = passwordValidator(password);
    if (isValid != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isValid,
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
    return isValid;
  }

  Null validateUsername(String username) {
    var isValid = usernameValidator(username);
    if (isValid != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isValid,
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
    return isValid;
  }

  void submitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (!_isLogin) {
      if (_passwordController.text != _repeatPasswordController.text) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Passwords do not match',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        return;
      }
    }
    final _firebaseAuth = FirebaseAuth.instance;
    setState(() {
      _isSubmitting = true;
    });
    try {
      if (_isLogin) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } else {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSubmitting = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      switch (e.code) {
        case 'INVALID_LOGIN_CREDENTIALS':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Invalid login credentials. Please try again.',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'An error occurred. Please try again later.',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_isLogin)
            const Text('Hello Again!', style: TextStyle(fontSize: 15)),
          if (_isLogin)
            const Text("Welcome back, you've been missed!",
                maxLines: 1, style: TextStyle(fontSize: 20)),
          if (!_isLogin)
            const Text('Create an Account', style: TextStyle(fontSize: 15)),
          if (!_isLogin)
            const Text(
              'Sign up to get started!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                  child: Column(children: [
                    _isLogin
                        ? AuthFieldColumn(
                            key: const ValueKey('login'),
                            isLogin: _isLogin,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            repeatPasswordController: _repeatPasswordController,
                            usernameController: _usernameController,
                            submitForm: submitForm,
                            validateEmail: validateEmail,
                            validatePassword: validatePassword,
                            validateUsername: validateUsername,
                          )
                        : AuthFieldColumn(
                            key: const ValueKey('register'),
                            isLogin: _isLogin,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            repeatPasswordController: _repeatPasswordController,
                            usernameController: _usernameController,
                            submitForm: submitForm,
                            validateEmail: validateEmail,
                            validatePassword: validatePassword,
                            validateUsername: validateUsername,
                          ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator())
                            : Text(_isLogin ? 'Login' : 'Register'),
                      ),
                    ),
                  ])),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_isLogin
                  ? 'Don\'t have an account?'
                  : 'Already have an account?'),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? 'Sign Up' : 'Login',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
