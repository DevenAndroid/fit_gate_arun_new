class Validation {
  static nameValidation(String? value) {
    if (value!.isEmpty) {
      return "Required";
    }
    return null;
  }

  static cprValidation(String? value) {
    if (value!.isEmpty) {
      return "Required";
    } else if (value.length != 9) {
      return "Please enter 9 digit valid no.";
    }
    return null;
  }
}
