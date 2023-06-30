
String? validateText(String? value, String error) {
  if (value == null || value.trim().isEmpty) {
    return error;
  } else {
    return null;
  }
}




// String? validatePassword(
//     String? value, bool forPass, bool forCurrentPass, bool changePassword) {
//   String removeWhiteSpace = value!.replaceAll(' ', '');
//
//   bool hasUppercase = removeWhiteSpace.contains(RegExp(r'[A-Z]'));
//   bool hasDigits = removeWhiteSpace.contains(RegExp(r'[0-9]'));
//   bool hasLowercase = removeWhiteSpace.contains(RegExp(r'[a-z]'));
//   bool hasSpecialCharacters =
//       removeWhiteSpace.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
//
//   if (value.removeWhiteSpace.isEmpty) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewRequiredPassword
//             : LocalizationStrings().keyRequiredPassword
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRequired
//             : LocalizationStrings().keyRequiredConfirmPassword;
//   } else if (value.removeWhiteSpace.length > 16 ||
//       value.removeWhiteSpace.length < 8 ) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasUppercase && !hasLowercase && !hasDigits) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasUppercase && !hasDigits && !hasSpecialCharacters) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasUppercase && !hasLowercase && !hasSpecialCharacters) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasLowercase && !hasDigits && !hasSpecialCharacters) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasUppercase && !hasLowercase) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasUppercase && !hasSpecialCharacters) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasDigits && !hasSpecialCharacters) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasLowercase && !hasSpecialCharacters) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasUppercase) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasLowercase) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasDigits) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else if (!hasSpecialCharacters) {
//     return forPass
//         ? changePassword
//             ? LocalizationStrings().keyNewPasswordRangeValidation
//             : LocalizationStrings().keyPasswordRangeValidation
//         : forCurrentPass
//             ? LocalizationStrings().keyCurrentPasswordRangeValidation
//             : LocalizationStrings().keyConfirmPasswordRangeValidation;
//   } else {
//     return null;
//   }
// }
//
// String? validateMobile(String? value) {
// // Indian Mobile number are of 10 digit only
//   if (value!.isEmpty) {
//     return LocalizationStrings().keyMobileNumberRequiredValidation;
//   } else if (value.trim().length<8 || value.trim().length > maxMobileLength) {
//     return LocalizationStrings().keyMobileNumberLengthValidation;
//   } else {
//     return null;
//   }
// }
//
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
