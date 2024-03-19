String? validateCryllic(String value, context) {
  String pattern = r'(^[а-яА-ЯӨөҮүЁёӨө 0-9-]+$)';
  RegExp isValidName = RegExp(pattern);
  if (value.isEmpty) {
    return "Заавал оруулна";
  } else {
    if (!isValidName.hasMatch(value)) {
      return "Зөвхөн крилл үсэг ашиглана";
    } else {
      return null;
    }
  }
}

String? validateEmail(String value, context) {
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty) {
    return 'И-Мейлээ оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'И-Мейлээ шалгана уу';
    } else {
      return null;
    }
  }
}

String? validatePhone(String value, context) {
  RegExp regex = RegExp(r'[(9|8]{1}[0-9]{7}$');
  if (value.isEmpty) {
    return 'Утасны дугаараа оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Утасны дугаараа шалгана уу';
    } else {
      return null;
    }
  }
}

String? englishValidate(String name, context) {
  String pattern = r'^[a-zA-Z 0-9-]+$';
  RegExp isValidName = RegExp(pattern);
  if (name.isEmpty) {
    return "Заавал оруулна";
  } else {
    if (!isValidName.hasMatch(name)) {
      return "Зөвхөн латин үсэг ашиглана";
    } else {
      return null;
    }
  }
}

String? registerNoValidate(String value, context) {
  RegExp regex = RegExp(r'^[А-Яа-я|Үү|Өө|Ёё]{2}\d{8}$');
  if (value.isEmpty) {
    return 'Регистр оруулна уу';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Регистр шалгана уу';
    } else {
      return null;
    }
  }
}
