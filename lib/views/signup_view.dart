

import 'package:flutter/material.dart';
import 'package:project/controllers/signup_controller.dart';
import 'package:project/helpers/validator.dart';
import 'package:project/views/verify_email_view.dart';
import 'package:provider/provider.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/helpers/utility.dart';
import 'package:project/views/login_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';




class SignUpView extends StatelessWidget {

  static const id = '/SignUp';
  late String _university,_email,_password,_passwordConfirmation;
  late String _type='t';


  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignUpController>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppbarWidget(
        text: 'ثبت نام',
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 30,
          top: 30
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

          Image.asset('$baseUrlImage/img_verify.png',
              width: 200.0, height: 200.0, fit: BoxFit.cover),
          Form(
              key: controller.formSignupKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleWidget('نقش', theme),

                    Consumer<SignUpController>(
                      builder: (context, value, child) =>
                          DropdownButtonFormField<String>(
                            decoration:  InputDecoration(
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyColors.pinkAccentHex,
                                    width: 1.5),
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: MyColors.pinkAccentHex,)),
                              filled: true,
                              contentPadding: const EdgeInsets.only(
                                  bottom: 10.0, left: 10.0, right: 10.0),
                            ),
                            validator: (newValue)
                            {
                              if(newValue == "انتخاب کنید")
                                {
                                  return 'لطفا یک مورد را انتخاب کنید';
                                }
                              return null;
                            },
                            value: value.dropdownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            style: theme.textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (String? newValue) {
                              value.updateValueFormField(newValue!);
                              if(newValue == "استاد"){
                                _type="t";
                              }else if(newValue =="دانشجو"){
                                _type="s";
                              }

                            },
                            items: <String>["استاد", "دانشجو","انتخاب کنید"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                    ),


                    _titleWidget('ایمیل', theme),

                     TextFormFieldWidget(
                        onChanged:(newValue) {
                          _email=newValue;
                        },
                        hintText: 'ایمیل خود را وارد کنید',
                        functionValidate: Validator.validateEmail,
                      ),

                    _titleWidget('دانشگاه', theme),
                    TextFormFieldWidget(
                      onChanged:(newValue) {
                        _university=newValue;
                      },
                      hintText: 'نام موسسه یا دانشگاه',
                      functionValidate: Validator.validateTextField,
                    ),

                    _titleWidget('رمز عبور', theme),

                     TextFormFieldWidget(
                       obscureText: true,
                       onChanged:(newValue) {
                         _password=newValue;
                       },
                      hintText: 'رمز عبور خود را وارد کنید',
                      functionValidate: Validator.validatePassword,
                    ),

                    _titleWidget('تکرار رمز عبور', theme),

                     TextFormFieldWidget(
                       obscureText: true,
                       onChanged:(newValue) {
                         _passwordConfirmation=newValue;
                       },
                      hintText: 'تکرار رمز عبور خود را وارد کنید',
                      functionValidate: (value){
                         if(value!.isEmpty)
                           {
                             return 'لطفا رمز عبور را وارد کنید';
                           }
                         if(value!=_password)
                           {
                             return 'تکرار رمز عبور با رمز عبور مطابقت ندارد !';
                           }
                         return null;
                      },
                    ),
                    sizedBox(height: 15),
                    Center(
                      child: Consumer<SignUpController>(
                        builder: (context, value, child) {
                          if(value.isLoading)
                            {
                              return const CircularProgressIndicator();
                            }
                          return ElevationButtonWidget(
                            call: () async{
                              if (value.formSignupKey.currentState!
                                  .validate()) {
                                var res= await value.SignUpRequest(_type, _university, _email, _password, _passwordConfirmation);
                                print(res);
                                if(res){ Navigator.of(context).pushNamed(VerifyEmailView.id);}
                                else{
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('خطا'),
                                      content: const Text('مشکلی در ثبت نام وحود دارد.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, '/SignUp'),
                                          child: const Text('باشه'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            text: 'ثبت نام',
                            primaryColor: MyColors.pinkAccentHex,
                            borderRadius: 20,
                          );
                        },

                      ),
                    )
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "حساب کاربری دارید؟",
                  style: theme.textTheme.subtitle2!

                ),
              ),
              InkWell(
                child: Text(
                  'ورود',
                  style: theme.textTheme.subtitle2!.copyWith(
                      color: MyColors.pinkAccentHex
                  ),
                ),
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(
                        LoginView.id),

                ),

            ],
          )
        ]),
      ),
    );
  }

  Widget _titleWidget(String name,ThemeData theme)
  {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: theme.textTheme.subtitle1,
      ),
    );
  }
}
