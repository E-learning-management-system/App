
import 'package:flutter/material.dart';
import 'package:project/controllers/search_controller.dart';
import 'package:project/helpers/colors.dart';
import 'package:project/helpers/utility.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);
  static const String id = '/search_view';

  @override
  Widget build(BuildContext context) {
    final  controller = Provider.of<SearchController>(context);

    return Scaffold(
      appBar: AppbarWidget(
        text: 'جست و حو',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30,
            right: 15,
            left: 15),
        child: Column(
          children: [
            TextFormFieldWidget(hintText: 'کلمه مورد نظر را وارد کنید',
                fillColor: MyColors.blueAccentHex,
                noneEnableBorder: false,
                colorHint: Colors.white,
                textTypeColor: Colors.white,
                actionKeyboard: TextInputAction.search,
                filled: true),
            sizedBox(height: 12,),
            Row(
              children: [
                const Text('نتایج جست و جو',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                sizedBox(width: 4),
                Icon(Icons.search,color: Colors.yellow,)
              ],
            ),
            _buildListSearch()

          ],
        ),
      ),
    );
  }

  _buildListSearch()
  {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 15,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8,
          vertical: 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 7/8,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Image.asset(Utility.randomImage(),
              height: 100,
              width: 100,),
            sizedBox(height: 4),
            const Text('سیگنال و سیستم ها',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,)
          ],
        );
      },);
  }
}

