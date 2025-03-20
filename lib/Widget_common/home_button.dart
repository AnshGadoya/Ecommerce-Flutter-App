import 'package:emart_app/Widget_common/commonButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

Widget homeButton({width, height, icon, String? title,OnPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: OnPress,
        child: Image.asset(icon, width: 26)),
      10.heightBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  ).box.rounded.white.size(width, height).make();
}
