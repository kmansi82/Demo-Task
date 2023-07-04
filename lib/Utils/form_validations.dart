
String? validateText(String? value, String error) {
  if (value == null || value.trim().isEmpty) {
    return error;
  } else {
    return null;
  }
}


String? validateOtp(String? value, {bool clearValidation = false}) {
  if (clearValidation) {
    return null;
  } else if (value!.isEmpty) {
    return 'Otp is required.';
  } else if (value.trim().length < 6) {
    return 'Otp must be of 6 digits.';
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (value!.isEmpty) {
    return 'Email is required.';
  } else if (regex.hasMatch(value)) {
    return null;
  } else {
    return 'Please enter valid email.';
  }
}
