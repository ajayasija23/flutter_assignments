import 'package:emojis_demo/home_page.dart';
import 'package:emojis_demo/login_page.dart';
import 'package:emojis_demo/util/firebase_helper.dart';
import 'package:emojis_demo/util/theme.dart';
import 'package:emojis_demo/util/util_functions.dart';
import 'package:emojis_demo/widget_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spinning_wheel/controller/spin_controller.dart';

class SignupPage extends StatefulWidget {


  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SpinnerController controller = SpinnerController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isValid=false;
  bool isLoading=false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSignupPage(context),
    );
  }

  Widget _buildSignupPage(BuildContext context) {

    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.h,
            Center(child: SvgPicture.asset("assets/ic_login.svg")),
            16.h,
            Center(child: Text("Enter Signup Details",style: TextStyles.robotoH1)),
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
            PasswordField(
              controller: confirmPasswordController,
              padding: 0.0,
              label: "Confirm Password",
            ),
            30.h,
            SimpleButton(text: "Signup",textColor: Colors.white,).onTap((){
              final isValid= validateForm();
              setState(() {
                this.isValid=isValid;
                if(isValid){
                  isLoading=true;
                }
              });
              if(isValid){
                FirebaseHelper.createAccountWithEmailPassword(emailController.text, passwordController.text, (code,message){
                  setState(() {
                    isLoading=false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                });
              }
            }),
            16.h,
            Center(
                child: Text("Already have an account? Login",style: TextStyles.robotoBody.copyWith(color: primaryColor))
            ).onTap(
                ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()))
            ),
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
    else if(confirmPasswordController.text.isEmpty){
      UtilFunctions.showSnackBar(context, "Please enter confirm password");
      return false;
    }
    else if(passwordController.text!=confirmPasswordController.text){
      UtilFunctions.showSnackBar(context, "Password and confirm password does not match");
      return false;
    }
    return true;
  }


}


