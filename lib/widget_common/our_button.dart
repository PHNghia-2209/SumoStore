import 'package:emart/consts/consts.dart';

Widget ourButton({onPress, color, txtColor, String? title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: color, padding: const EdgeInsets.all(12)),
        
    onPressed: onPress,
    child: title!.text.color(txtColor).fontFamily(bold).make(),
  );
}
