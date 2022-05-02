

class Validator{




  static String? validateEmail(String? email) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'لطفا ایمیل را وارد کنید';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'ایمیل وارد شده صحیح نمی باشد';
    }

    return null;
  }

  static String? validatePassword(String? password) {

     final regExpJustNumber = RegExp(r'(^(?:[+0]9)?[0-9]{8,10}$)');
     final regExpPersianCharacters = RegExp(r'^[\u0622\u0627\u0628\u067E\u062A-\u062C\u0686\u062D-\u0632\u0698\u0633-\u063A\u0641\u0642\u06A9\u06AF\u0644-\u0648\u06CC]+$');

    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'لطفا رمز عبور را وارد کنید';
    } else if (password.length < 8) {
      return 'رمز عبور با طول حداقل 8 وارد کنید';
    }else if(regExpJustNumber.hasMatch(password))
      {
        return 'رمز عبور باید دارای کاراکتر هم باشد';
      }
    else if (regExpPersianCharacters.hasMatch(password.replaceAll(' ', '')))
      {
        return 'لطفا از حروف فارسی استفاده نکنید';
      }

    return null;
  }

 static  String? validateTextField(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'لطفا نام دانشگاه خود را وارد کنید';
    } else {
      return null;
    }
  }

}