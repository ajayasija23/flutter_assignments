import 'package:emojis_demo/base_widgets.dart';
import 'package:emojis_demo/quiz_screen.dart';
import 'package:emojis_demo/util/theme.dart';
import 'package:emojis_demo/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends BaseStatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(child: Center(
      child: Column(
        children: [
          Spacer(),
          Text("Math Master",style: TextStyles.robotoH1.copyWith(color: primaryColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          16.h,
          SvgPicture.asset("assets/ic_logo.svg",height: 150,width: 150,),
          16.h,
          Text("Learn Math by Playing Game",style: TextStyles.robotoBody,textAlign: TextAlign.center,),
          Spacer(),
          SimpleButton(text: "Get Started",textColor: Colors.white,).onTap(
              ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()))
          ),
          16.h,
        ],
      ),
    ));
  }
}



