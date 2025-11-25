import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../controllers/group_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/payment_controller.dart';
import '../controllers/register_controller.dart';
import '../controllers/safety_controller.dart';
import '../controllers/splash_controller.dart';
import '../routes/app_routes.dart';
import '../ui/screens/chat_screen.dart';
import '../ui/screens/guide_profile_screen.dart';
import '../ui/screens/group_joining_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/payment_screen.dart';
import '../ui/screens/register_screen.dart';
import '../ui/screens/root_shell.dart';
import '../ui/screens/safety_screen.dart';
import '../ui/screens/splash_screen.dart';
import '../ui/screens/guide_dashboard.dart';
import '../ui/screens/user_dashboard.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: BindingsBuilder(() {
        Get.put(RegisterController());
      }),
    ),
    GetPage(
      name: AppRoutes.root,
      page: () => const RootShell(),
      binding: BindingsBuilder(() {
        Get.put(NavigationController());
        Get.put(HomeController());
        Get.put(GroupController());
        Get.put(SafetyController());
        Get.put(PaymentController());
        Get.put(ChatController());
      }),
      children: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/groups', page: () => const GroupJoiningScreen()),
        GetPage(name: '/safety', page: () => const SafetyScreen()),
        GetPage(name: '/profile', page: () => const GuideProfileScreen()),
      ],
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<PaymentController>()) {
          Get.put(PaymentController());
        }
      }),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<ChatController>()) {
          Get.put(ChatController());
        }
      }),
    ),
    GetPage(
      name: AppRoutes.userDashboard,
      page: () => const UserDashboard(),
    ),
    GetPage(
      name: AppRoutes.guideDashboard,
      page: () => const GuideDashboard(),
    ),
  ];
}
