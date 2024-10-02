import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controller/cart_controller.dart';
import 'package:emart/services/filestore_services.dart';
import 'package:emart/view/order/order_detail_screen.dart';
import 'package:emart/widget_common/loading_indicator.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreService.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders yet!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}"
                      .text
                      .fontFamily(bold)
                      .color(darkFontGrey)
                      .xl
                      .make(),
                  tileColor: lightGrey,
                  onTap: () async {
                      Get.to(() => OrderDetailScreen(data: data[index]));
                  },
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .fontFamily(semibold)
                      .make(),
                  trailing: IconButton(
                    onPressed: () async {
                      Get.to(() => OrderDetailScreen(data: data[index]));
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                    color: darkFontGrey,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
