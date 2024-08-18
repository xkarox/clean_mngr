import 'package:clean_mngr/widgets/auth/auth_field.dart';
import 'package:flutter/material.dart';

class AuthFieldColumn extends StatelessWidget{
  final bool isLogin;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController repeatPasswordController;
  final TextEditingController usernameController;
  final Function() submitForm;
  final Function(String) validateEmail;
  final Function(String) validatePassword;
  final Function(String) validateUsername;

  const AuthFieldColumn({super.key, required this.isLogin, required this.passwordController, required this.emailController, required this.repeatPasswordController, required this.usernameController, required this.submitForm, required this.validateEmail, required this.validatePassword, required this.validateUsername});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (!isLogin)
          AuthField(
                labelText: 'Username',
                controller: usernameController,
                validator: (username) => validateUsername(username)),
        AuthField(
            labelText: 'Email',
            controller: emailController,
            validator: (email) => validateEmail(email)),
        AuthField(
            labelText: 'Password',
            isObscure: true,
            controller: passwordController,
            validator: (password) =>
                isLogin ? null : validatePassword(password)),
        if (!isLogin)
          AuthField(
              labelText: 'Confirm Password',
              isObscure: true,
              controller: repeatPasswordController,
              validator: (password) => validatePassword(password)),
        
      ],
    );
  }
}