import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var featuredList = [];
  var currentNavIndex = 0.obs;
  var username = '';
  var searchController = TextEditingController();

  getUsername() async {
    var nameFb = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = nameFb.toString();
  }

  fetchFeatured(data) {
    featuredList.clear();
    for (var i = 0; i < data.length; i++) {
      featuredList.add(data[i]);
    }
    return featuredList.shuffle();
  }
}
