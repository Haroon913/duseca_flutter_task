import 'package:duseca_flutter_task/utils/routes/routes_name.dart';
import 'package:duseca_flutter_task/views/language_selection/language_selection.dart';
import 'package:duseca_flutter_task/views/auth/login_screen.dart';
import 'package:duseca_flutter_task/views/home/home_screen.dart';
import 'package:get/get.dart';

import '../../views/auth/signup_screen.dart';

class AppRoutes{
static appRoutes()=>[

  GetPage(
      name: RouteName.loginScreen,
      page: ()=>  const LoginScreen(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: RouteName.signupScreen,
      page: ()=>  const SignupScreen(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: RouteName.languageSelectionScreen,
      page: ()=>  LanguageSelectionScreen(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: RouteName.homeScreen,
      page: ()=>  HomeScreen(),
      transition: Transition.leftToRightWithFade),
];
}