class CValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    // Check for spaces
    if (value.contains(RegExp(r'\s'))) {
      return 'Password cannot contain spaces.';
    }
    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }

    // Check for uppercase letters
    // if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one uppercase letter.';
    // }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character.';
    // }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }

  static String? validateSsn(String? value) {
    if (value == null || value.isEmpty) {
      return 'SSN is required.';
    }

    // Check if the value consists only of digits and has a length of 14
    if (value.length != 14 || !value.contains(RegExp(r'^\d+$'))) {
      return 'Invalid SSN format (14 digits required).';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required.';
    }

    // Check if the username contains any whitespace
    if (value.contains(RegExp(r'\s'))) {
      return 'Username cannot contain whitespace.';
    }

    return null;
  }

  static String? validateFirstName(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'First Name is required.';
    }

    // Check if the name contains any characters other than letters
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'First Name must contain only letters.';
    }

    // Check if the name contains any spaces
    if (value.contains(RegExp(r'\s'))) {
      return 'First Name cannot contain spaces.';
    }

    // You can add more validations here, such as checking for minimum or maximum name length

    return null;
  }

  static String? validateSecondName(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Second Name is required.';
    }

    // Check if the name contains any characters other than letters
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Second Name must contain only letters.';
    }

    // Check if the name contains any spaces
    if (value.contains(RegExp(r'\s'))) {
      return 'Second Name cannot contain spaces.';
    }

    // You can add more validations here, such as checking for minimum or maximum name length

    return null;
  }

  static String? validateUsernameOrEmail(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Username Or Email is required.';
    }
// Add more custom validators as needed for your specific requirements.
    return null;
  }

  static String? validateSets(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Sets is required.';
    }

    return null;
  }

  static String? validateReps(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Reps is required.';
    }

    return null;
  }

  static String? validateRest(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Rest is required.';
    }

    return null;
  }

  static String? validateRir(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'RIR is required.';
    }

    return null;
  }
}
