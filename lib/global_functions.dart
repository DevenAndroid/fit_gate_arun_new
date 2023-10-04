import 'dart:convert';

import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'models/active_subscription_model.dart';
import 'models/user_model.dart';

// var header = {
// };

Future<Map<String, String>> get header async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.getString("isLogin") == null)
    return {
      "content-type": "application/json",
    };
  Global.userModel = UserModel.fromJson(jsonDecode(pref.getString("isLogin")!));
  return {"content-type": "application/json", "Authorization": "Bearer ${Global.userModel?.id}"};
}

Widget launchWebView(url) {
  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (NavigationRequest request) {
        print("REQUEST ${request.url}");
        return NavigationDecision.navigate;
      },
    ))
    ..loadRequest(Uri.parse(url));
  return Scaffold(
      body: SafeArea(
    child: WebViewWidget(
      controller: controller,
    ),
  ));
}

Future<T?> push<T>({
  required BuildContext context,
  required Widget screen,
  bool pushUntil = false,
}) {
  if (pushUntil) {
    return Navigator.of(context)
        .pushAndRemoveUntil<T>(MaterialPageRoute(builder: (_) => screen), (Route<dynamic> route) => false);
  }
  return Navigator.of(context).push<T>(MaterialPageRoute(builder: (_) => screen));
}

//  await Permission.location.request();
//
//   permission = await Geolocator.checkPermission();
//   if (await Permission.location.isGranted) {
//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.low);
//     print("POSITIONNNNNN --------------       ${position}");
//     return position;
//   }
//   return null;
// snackBar(msg, {Color? color}) {
//   return Get.showSnackbar(GetSnackBar(
//     duration: Duration(seconds: 2),
//     backgroundColor: color ?? Colors.red.shade700,
//     message: msg,
//     // message: "dsfds",
//   ));
// }

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

dynamic snackBar(msg, {Color? color, VoidCallback? onTap, duration}) {
  final SnackBar snackBar = SnackBar(
    backgroundColor: color ?? Colors.red.shade700,
    duration: Duration(milliseconds: duration ?? 2000),
    behavior: SnackBarBehavior.floating,
    content: GestureDetector(
      onTap: onTap,
      child: Text(msg ?? "Something went wrong :("),
    ),
    elevation: 1000,
  );
  snackbarKey.currentState?.showSnackBar(
    snackBar,
  );
}

showToast(
  message, {
  Color? color,
}) {
  EasyLoading.instance
    ..toastPosition = EasyLoadingToastPosition.top
    ..textColor = MyColors.white
    ..backgroundColor = color ?? Colors.red.shade700;
  EasyLoading.showToast(message);
}

dynamic loading({@required bool? value, String? title, bool closeOverlays = false}) {
  if (value!) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..maskColor = MyColors.grey.withOpacity(.2)

      /// custom style
      ..loadingStyle = EasyLoadingStyle.custom
      ..progressColor = MyColors.white
      ..indicatorColor = MyColors.orange
      ..backgroundColor = MyColors.white
      ..textColor = MyColors.black

      ///
      ..userInteractions = false
      ..animationStyle = EasyLoadingAnimationStyle.offset
      ..dismissOnTap = kDebugMode;
    EasyLoading.show(
      maskType: EasyLoadingMaskType.custom,
      //status: "Loading..",
      dismissOnTap: true,
    );
  } else {
    EasyLoading.dismiss();
  }
}

/*sendOtp(dialCode, String phone) async {
  final auth = FirebaseAuth.instance;

  try {
    print("TRYYYYY ");
    await auth.verifyPhoneNumber(
      phoneNumber: '$dialCode $phone',
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("VERIFICATION COMPLETED");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("FAILEDDDDD");
        print("DIAL --------- $dialCode");
        print("DIAL CODE --------- $phone");
        print("ERORRRRR $e");
      },
      codeSent: (String? verificationID, int? resendToken) {
        print("CODE SENT");
        print("DIAL CODE --------- $dialCode");
        _resendToken = resendToken;
        Get.to(() => VerifyPhoneScreen(
              dialCode: dialCode,
              verificationId: verificationID,
              phone: phone,
            ));
        print("RESEND TOKEN $_resendToken");
      },
      timeout: Duration(minutes: 1),
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: (String? verificationId) {
        // verificationCode = verificationId;
        print("TIME OUT");
        // print("VERIFICATION ID${verificationId}");
      },
    );
  } catch (e) {
    print("ERRORRRRRRR $e");
  }
}*/

class Global {
  static UserModel? userModel;
  static ActiveSubscriptionModel? activeSubscriptionModel;
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
