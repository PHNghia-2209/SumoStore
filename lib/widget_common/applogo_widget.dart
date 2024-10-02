import 'package:emart/consts/consts.dart';

Widget appLogoWidget() {
  // using Velocity X here
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.asset(icAppLogo)
        .box
        .white
        .size(77, 77)
        .padding(const EdgeInsets.all(8))
        .make(),
  );
}
