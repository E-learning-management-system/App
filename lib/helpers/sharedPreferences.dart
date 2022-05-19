

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class SharedPreferences{
  EncryptedSharedPreferences encryptedSharedPreferences = EncryptedSharedPreferences();
  setString(key,value){
    encryptedSharedPreferences.setString(key, value);
  }
  getString(key){
    return encryptedSharedPreferences.getString(key);
  }
}
final sharedPreferences= SharedPreferences();

