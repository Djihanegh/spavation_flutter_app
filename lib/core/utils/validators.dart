class Validators {
  static isNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "This field should not be empty";
    }
    return null;
  }

  static isNameValid(String value) {
    if (value == null || value.isEmpty) {
      return "This field should not be empty";
    }

    if (RegExp(r'^[a-zA-Z0-9]').hasMatch(value)) {
      return null;
    } else {
      return "Only alphanumeric characters are accepted";
    }
  }

  static bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static bool passwordsMatch(String password, String confirmationPassword) {
    return password == confirmationPassword;
  }
}
