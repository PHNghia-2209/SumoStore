import 'package:emart/consts/consts.dart';
import 'package:emart/view/category_screen/category_screen.dart';
import 'package:emart/view/category_screen/categorydetail_screen.dart';
import 'package:get/get.dart';

Widget featureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadow
      .make()
      .onTap(() {
    Get.to(() =>  CategoryDetails(title: title));
  });
}
