import 'package:fit_gate/custom_widgets/custom_btns/custom_button.dart';
import 'package:fit_gate/screens/auth/login_screen.dart';
import 'package:fit_gate/screens/auth/sign_up_screen.dart';
import 'package:fit_gate/utils/my_color.dart';
import 'package:fit_gate/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _controller;
  // late ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/intro_video.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);

        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
    // chewieController = ChewieController(
    //   videoPlayerController: _controller,
    //   autoPlay: true,
    //   looping: true,
    //   allowFullScreen: true,
    //   showControls: false,
    //   aspectRatio: 16 / 9,
    //   deviceOrientationsAfterFullScreen: [
    //     DeviceOrientation.landscapeRight,
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    //   ],
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    // chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: Container(
                    // constraints: BoxConstraints(
                    //   maxHeight: MediaQuery.of(context).size.height,
                    // ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      MyImages.logo,
                      height: 110,
                      width: 200,
                    ),
                    // Spacer(),
                    Container(
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
                    )
                  ],
                ),
                // SizedBox(height: 30),
                Text(
                  "Muscle Up Your\nBody Physique",
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 33,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Explore amazing features and offers with\nPro Subscription",
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Spacer(),
                CustomButton(
                  title: "Get Started",
                  borderRadius: BorderRadius.circular(12),
                  height: MediaQuery.of(context).size.height * 0.06,
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setInt("intro", 1);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()),
                        (route) => false);
                  },
                ),
                SizedBox(height: 25),
                CustomButton(
                  title: "Login",
                  bgColor: Colors.transparent,
                  borderColor: MyColors.white,
                  borderRadius: BorderRadius.circular(12),
                  height: MediaQuery.of(context).size.height * 0.06,
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setInt("intro", 1);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false);
                  },
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
