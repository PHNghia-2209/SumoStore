import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controller/cart_controller.dart';
import 'package:emart/services/filestore_services.dart';
import 'package:emart/view/cart_screen/shipping_screen.dart';
import 'package:emart/widget_common/loading_indicator.dart';
import 'package:get/get.dart';

import '../../widget_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
            height: 60,
            child: ourButton(
              color: redColor,
              onPress: () {
                Get.to(() => const ShippingDetails());
              },
              txtColor: whiteColor,
              title: "Proceed to shipping",
            )),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FireStoreService.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: "Cart is empty".text.color(darkFontGrey).make());
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['image']}",
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data[index]['title']}"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                                "Quantity: ${data[index]['quantity']}"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                                Row(
                                  children: [
                                    "Color: "
                                        .text
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make(),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      color: Color(data[index]['color']),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: "${data[index]['totalPrice']}"
                                .numCurrency
                                .text
                                .size(16)
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() {
                              // showDialogConfirmDelete();
                              FireStoreService.deleteDocument(data[index].id);
                            }),
                          );
                        },
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(golden)
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            }));
  }
}
