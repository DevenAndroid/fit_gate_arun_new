import 'package:fit_gate/custom_widgets/custom_btns/custom_button.dart';
import 'package:fit_gate/screens/auth/login_screen.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(MyImages.intro_bg),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Image.asset(MyImages.logo)),
                  Spacer(),
                  Expanded(
                    flex: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          MyImages.intro,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Muscle Up Your\nBody Physique",
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Explore amazing features and offers with Pro Subscription",
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w100,
                ),
              ),
              Spacer(),
              // CustomButton(
              //   title: "Get Started",
              //   borderRadius: BorderRadius.circular(12),
              // ),
              // SizedBox(height: 20),
              CustomButton(
                title: "Login",
                // bgColor: Colors.transparent,
                // borderColor: MyColors.white,
                borderRadius: BorderRadius.circular(12),
                height: MediaQuery.of(context).size.height * 0.06,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
