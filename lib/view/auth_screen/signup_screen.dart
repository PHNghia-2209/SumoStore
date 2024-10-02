import 'package:emart/consts/consts.dart';
import 'package:emart/controller/auth_controller.dart';
import 'package:emart/view/home_screen/home.dart';
import 'package:get/get.dart';

import '../../widget_common/applogo_widget.dart';
import '../../widget_common/bg_widget.dart';
import '../../widget_common/custom_textfield.dart';
import '../../widget_common/our_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Join the $appName".text.white.fontFamily(bold).size(18).make(),
              15.heightBox,
              Obx(
                () => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    children: [
                      customerTextField(
                          hint: nameHint,
                          title: name,
                          controller: nameController,
                          isPass: false),
                      customerTextField(
                          hint: emailHint,
                          title: email,
                          controller: emailController,
                          isPass: false),
                      customerTextField(
                          hint: passwordHint,
                          title: password,
                          controller: passwordController,
                          isPass: true),
                      customerTextField(
                          hint: passwordHint,
                          title: confirmPassword,
                          controller: confirmController,
                          isPass: true),
                      10.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            activeColor: redColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                          ),
                          1.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                      text: "I agree to the ",
                                      style: TextStyle(
                                        fontFamily: regular,
                                        fontSize: 16.0,
                                        color: fontGrey,
                                      )),
                                  TextSpan(
                                      text: termAndCondition,
                                      style: TextStyle(
                                        fontFamily: regular,
                                        fontSize: 16.0,
                                        color: redColor,
                                      )),
                                  TextSpan(
                                      text: "&",
                                      style: TextStyle(
                                        fontFamily: regular,
                                        fontSize: 16.0,
                                        color: fontGrey,
                                      )),
                                  TextSpan(
                                      text: privacyPolicy,
                                      style: TextStyle(
                                        fontFamily: regular,
                                        fontSize: 16.0,
                                        color: redColor,
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      10.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: isCheck == true ? redColor : lightGrey,
                              title: signUp,
                              txtColor: whiteColor,
                              onPress: () async {
                                if (isCheck != false) {
                                  controller.isLoading(true);
                                  try {
                                    await controller
                                        .signUpMethod(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .then((value) {
                                      return controller
                                          .storeUerData(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text)
                                          .then((value) {
                                        VxToast.show(context, msg: loggedIn);
                                        Get.offAll(() => const Home());
                                      });
                                    });
                                  } catch (e) {
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                    controller.isLoading(false);
                                  }
                                }
                              },
                            ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      //Wapping into gesture detector of velocity X
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: alreadyHaveAccount,
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: login,
                              style: TextStyle(
                                fontFamily: bold,
                                color: redColor,
                              ),
                            ),
                          ],
                        ),
                      ).onTap(() {
                        Get.back();
                      }),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
