String? _validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter an email address';
  } else if (!isValidEmail(value)) {
    return 'Please enter a valid email address';
  }
  return null; // Return null if the input is valid
}

bool isValidEmail(String input) {
  // You can use a regular expression or any other method to validate the email format.
  // For simplicity, this example only checks for basic email format.
  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegExp.hasMatch(input);
}
