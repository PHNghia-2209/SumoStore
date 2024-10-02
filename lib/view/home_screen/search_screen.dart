import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';

import '../../services/filestore_services.dart';
import '../../widget_common/loading_indicator.dart';
import '../category_screen/item_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.make(),
      ),
      body: FutureBuilder(
          future: FireStoreService.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Products Found!"
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where((element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()))
                  .toList();

              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 300,
                  crossAxisSpacing: 10,
                ),
                children: filtered.mapIndexed((currentValue, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        filtered[index]['p_imgs'][0],
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const Spacer(),
                      "${filtered[index]['p_name']}"
                          .text
                          .white
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "${filtered[index]['p_price']}"
                          .numCurrency
                          .text
                          .white
                          .fontFamily(bold)
                          .color(redColor)
                          .size(16)
                          .make(),
                      10.heightBox,
                    ],
                  )
                      .box
                      .white
                      .outerShadowMd
                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                      .padding(const EdgeInsets.all(12))
                      .make()
                      .onTap(() {
                    Get.to(() => ItemDetail(
                          title: "${filtered[index]['p_name']}",
                          data: filtered[index],
                        ));
                  });
                }).toList(),
              );
            }
          }),
    );
  }
}
