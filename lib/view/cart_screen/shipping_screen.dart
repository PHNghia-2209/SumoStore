import 'package:emart/consts/consts.dart';
import 'package:emart/view/cart_screen/payment_method.dart';
import 'package:emart/widget_common/custom_textfield.dart';
import 'package:emart/widget_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/cart_controller.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    var address = controller.addressController;
    var city = controller.cityController;
    var state = controller.stateController;
    var postalCode = controller.postalCodeController;
    var phone = controller.phoneController;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        child: ourButton(
          color: redColor,
          onPress: () {
            if (address.text.length > 10) {
              Get.to(() => const PaymentMethods());
              
            } else {
              VxToast.show(context, msg: "Please fill the form!");
            }
          },
          txtColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customerTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: address),
            customerTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: city),
            customerTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: state),
            customerTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: postalCode),
            customerTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: phone),
          ],
        ),
      ),
    );
  }
}
