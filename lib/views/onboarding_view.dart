

import 'package:flutter/material.dart';
import 'package:project/controllers/onboarding_controller.dart';
import 'package:project/models/local_models/onboarding_model.dart';


import 'package:project/helpers/colors.dart';
import 'package:project/views/login_view.dart';
import 'package:project/views/signup_view.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';

import 'package:provider/provider.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);
  static String id = '/onBoarding';

  @override
  Widget build(BuildContext context) {

    final controller =  context.watch<OnBoardingController>();
    final theme =Theme.of(context);
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 180,
                  child: PageView(
                    scrollBehavior: const ScrollBehavior()
                        .copyWith(overscroll: false),
                    controller: controller.pageController,
                    children: controller.list.map((data) =>
                    _buildItemOnBoarding(data, theme)).toList(),
                    onPageChanged: (value) {
                      controller.updateValuePageView(value);
                    },
                  ),
                ),
                sizedBox(height: 20),
                _buildIndicator(),
              ],
            ),

            _buildButtons()

          ],
        )
    );
  }


  Widget _buildItemOnBoarding(OnBoardingModel model, ThemeData theme)
  {
    return   Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(model.imageUrl,
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover),
          Text(
          model.title!,
            style: theme.textTheme.headline5!.copyWith(
              color: Colors.black
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              model.desc!,
              textDirection: TextDirection.rtl,
              style: theme.textTheme.subtitle1,
            ),
          ),
        ]);

  }

  Widget _buildIndicator()
  {
    return Consumer<OnBoardingController>(
      builder: (context, value, child) {
        return SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < value.list.length; i++)
                if (i == value.currentPage) ...[_buildItemIndicator(true)] else
                  _buildItemIndicator(false),
            ],
          ),
        );
      },

    );
  }

  Widget _buildItemIndicator(bool sellected)
  {
    return AnimatedContainer(
        duration: const Duration(
          milliseconds: 150
        ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: sellected? 10 :8,
      width: sellected? 10 :8,
      decoration: BoxDecoration(
        color: sellected ? MyColors.blueHex : MyColors.blueAccentHex,
          borderRadius: const BorderRadius.all(Radius.circular(12)
          )
      ),
    );
  }

  Widget _buildButtons()
  {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Builder(
        builder: (context) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ElevationButtonWidget(
              height: 45,
              width: 141,
              borderRadius: 30,
              primaryColor: MyColors.pinkAccentHex,
              text: 'ثبت نام',
              call: (){
                Navigator.of(context).pushNamed(SignUpView.id);
              },
            ),
            ElevationButtonWidget(
              height: 45,
              width: 141,
              borderRadius: 30,
              primaryColor: MyColors.blueAccentHex,
              text: 'ورود',
              call: (){
                Navigator.of(context).pushNamed(LoginView.id);

              },
            ),
          ],
        ),
      ),
    );
  }
}
