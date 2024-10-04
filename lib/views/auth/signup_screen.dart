import 'package:duseca_flutter_task/utils/components/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller/auth_controller.dart';
import '../../utils/appFonts/app_fonts.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/components/custom_text_field.dart';
import '../../utils/routes/routes_name.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController authController = Get.put(AuthController());
  final _signupformKey = GlobalKey<FormState>();

  void _submitLoginForm() {
    if (_signupformKey.currentState!.validate()) {
      authController.signup(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height*.99;
    final width=MediaQuery.of(context).size.width*.99;
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/auth_background.png',
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.3), // Applying opacity
              colorBlendMode: BlendMode.lighten,
            ),
          ),
          Positioned(
              top: height*.15,
              left: width*.05,
              right: width*.05,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to Breathin',style: AppFonts.heading(color: AppColors.whiteColor),),
                  Text('Please enter your details to continue',style: AppFonts.body(color: AppColors.whiteColor),),
                  SizedBox(height: height * .07),
                  Form(
                    key: _signupformKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          controller: authController.emailController.value,
                          heading: 'Email',
                          // label: 'Email',
                          hintText: 'example@gmail.com',
                          height: height*.005,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * .03),
                        Obx(
                              () => CustomTextField(
                            controller: authController.passwordController.value,
                            heading:'Password',
                            // label: 'Password',
                            hintText: 'must be 8 characters',
                            height: height*.005,
                            obscureText: authController.isPasswordObscured.value,
                            suffixIcon: authController.isPasswordObscured.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onSuffixTap: () =>
                                authController.togglePasswordVisibility(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * .05),
                  CustomButton(label: 'Continue', onPress: (){
                    _submitLoginForm();
                  }, isLoading: authController.isLoading,),
                  SizedBox(height: height * .015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                        style: AppFonts.body(color: AppColors.whiteColor).copyWith(fontWeight: FontWeight.normal),),
                      SizedBox(width: width * .01),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteName.loginScreen);
                        },
                        child: Text('LogIn',
                            style: AppFonts.body(color: AppColors.whiteColor)),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .05),
                  const OrDivider(),
                  SizedBox(height: height * .015),
                  CustomButton(label: 'Sign in with Google',
                    onPress: (){},
                    isLoading: authController.isSigningUp,
                    fillColor: AppColors.whiteColor,
                    borderColor: AppColors.blackColor,
                    assetImagePath: 'assets/images/google_logo.jpeg',
                  ),
                  SizedBox(height: height * .03),
                  CustomButton(label: 'Sign in with Apple',
                    onPress: (){},
                    isLoading: authController.isSigningUp,
                    fillColor: AppColors.whiteColor,
                    borderColor: AppColors.blackColor,
                    assetImagePath: 'assets/images/apple_logo.png',
                  ),


                ],
              ))
        ],
      ),
    );
  }
}
