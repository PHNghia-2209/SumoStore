import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controller/product_controller.dart';
import 'package:emart/widget_common/bg_widget.dart';
import 'package:get/get.dart';

import 'CategoryDetail_Screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: category.text.fontFamily(regular).white.make(),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      categoryListImage[index],
                      width: 200,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categoryList[index]
                        .text
                        .white
                        .align(TextAlign.center)
                        .fontFamily(semibold)
                        .size(13.5)
                        .color(darkFontGrey)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                    .padding(const EdgeInsets.all(12))
                    .make()
                    .onTap(() {
                  controller.getSubCategories(categoryList[index]);
                  Get.to(() => CategoryDetails(title: categoryList[index]));
                });
              }),
        ),
      ),
    );
  }
}
