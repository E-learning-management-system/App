

void main()
{
  bool isPhoneNoValid(String? phoneNo) {
    if (phoneNo == null) return false;
    final regExp = RegExp(r'^[\u0622\u0627\u0628\u067E\u062A-\u062C\u0686\u062D-\u0632\u0698\u0633-\u063A\u0641\u0642\u06A9\u06AF\u0644-\u0648\u06CC]+$');
    return regExp.hasMatch(phoneNo.replaceAll(' ', ''));
  }
  final z = isPhoneNoValid('رمز عبور با طول حداق');
  print(z);
}