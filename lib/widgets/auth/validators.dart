dynamic emailValidator(String? email) {
  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+', caseSensitive: false);
  if (email == null || email.isEmpty) {
    return 'Email is required' ;
  }
  if (!emailRegExp.hasMatch(email)) {
    return 'Please enter a valid email' ;
  }
  return null;
}


dynamic passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password is required' ;
  }
  if (password.length < 6) {
    return 'Password must be at least 6 characters' ;
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain a number' ;
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain a lowercase letter' ;
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain an uppercase letter' ;
  }
  return null;
}

dynamic usernameValidator(String? username) {
  if (username == null || username.isEmpty) {
    return 'Username is required' ;
  }
  if (username.length < 3) {
    return 'Username must be at least 3 characters' ;
  }
  return null;
}