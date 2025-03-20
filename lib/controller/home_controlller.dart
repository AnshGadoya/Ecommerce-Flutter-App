import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    if (currentUser != null) {
      getUserName();
    }
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var userName = '';
  var searchController = TextEditingController();
  getUserName() async {
    await firestore
        .collection(userController)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      userName = value.data()!['name'];
    });

    //userName = n;
  }
}
