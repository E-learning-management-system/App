


class Utility {


  static String? validateTextField(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'لطفا نام دانشگاه خود را وارد کنید';
    } else {
      return null;
    }
  }

}