import 'package:get/get.dart';
import 'package:todoapp/app.dart';
import 'package:todoapp/src/screens/create_task_screen.dart';
import 'package:todoapp/src/screens/login_screen.dart';
import 'package:todoapp/src/screens/register_screen.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: Routes.ROOT,
      page: () => App(),
    ),
    GetPage(
      name: Routes.CREATE_TASK,
      page: () => CreateTaskScreen(
        task: Get.arguments,
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterScreen(),
    ),
  ];
}
