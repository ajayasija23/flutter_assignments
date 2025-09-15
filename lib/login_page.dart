import 'package:emojis_demo/home_page.dart';
import 'package:emojis_demo/signup_page.dart';
import 'package:emojis_demo/util/firebase_helper.dart';
import 'package:emojis_demo/util/theme.dart';
import 'package:emojis_demo/util/util_functions.dart';
import 'package:emojis_demo/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spinning_wheel/controller/spin_controller.dart';

class LoginPage extends StatefulWidget {


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SpinnerController controller = SpinnerController();
  bool isValid=false;
  bool isLoading=false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildLoginPage(context),
    );
  }

  Widget _buildLoginPage(BuildContext context) {

    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.h,
            Center(child: SvgPicture.asset("assets/ic_login.svg")),
            16.h,
            Center(child: Text("Welcome back!",style: TextStyles.robotoH1)),
            16.h,
            OutlineTextField(
              controller: emailController,
              padding: 0.0,
              label: "Email",
              inputType: TextInputType.emailAddress,
            ),
            16.h,
            PasswordField(
              controller: passwordController,
              padding: 0.0,
              label: "Password",
            ),
            16.h,
            Align(alignment: Alignment.topRight,child: Text("Forgot Password?",style: TextStyles.robotoBody.copyWith(color: primaryColor),)),
            30.h,
            SimpleButton(text: "Login",textColor: Colors.white,).onTap((){
              final isValid= validateForm();
              setState(() {
                this.isValid=isValid;
                if(isValid){
                  isLoading=true;
                }
              });
              if(isValid){
                FirebaseHelper.loginWithEmailPassword(emailController.text, passwordController.text, (code,message){
                  setState(() {
                    isLoading=false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                });
              }
            }),
            16.h,
            Center(child: Text("Don't have an account? Signup",style: TextStyles.robotoBody.copyWith(color: primaryColor))).onTap((){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
            }),
            16.h,
            isLoading? Center(child: CircularProgressIndicator()):SizedBox(),
          ],
        ),
      ),
    );


  }

  bool validateForm() {
    if(emailController.text.isEmpty){
      UtilFunctions.showSnackBar(context, "Please enter email");
      return false;
    }
    else if(passwordController.text.isEmpty){
      UtilFunctions.showSnackBar(context, "Please enter password");
      return false;
    }
    return true;
  }

}


