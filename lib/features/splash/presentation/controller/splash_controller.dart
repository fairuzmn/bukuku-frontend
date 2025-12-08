import 'package:bukuku_frontend/core/session/session_controller.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController(this.sessionController);

  final SessionController sessionController;

  @override
  void onReady() {
    super.onReady();
    init();
  }

  void init() async {
    var user = await sessionController.initLocalUser();
    if (user != null) {
      Get.offAllNamed(AppLinks.dashboard);
      return;
    }

    Get.offAllNamed(AppLinks.authLogin);
  }
}
