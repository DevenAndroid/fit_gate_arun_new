import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/screens/bottom_bar_screens/account_screen.dart';
import 'package:fit_gate/screens/subscription_page.dart';
import 'package:fit_gate/test.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/bottom_controller.dart';
import '../custom_widgets/custom_app_bar.dart';

class CheckOutPage extends StatefulWidget {
  final String? id;
  CheckOutPage({Key? key, this.id}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final bottomController = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    print('SUBS ID  --------------      ${widget.id}');
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("${EndPoints.paymentPage}/${widget.id}"),
        method: LoadRequestMethod.get,
        headers: {"content-type": "application/json", "Authorization": "Bearer ${Global.userModel?.id}"},
        // body: Uint8List.fromList(
        //   utf8.encode(
        //     jsonEncode({"id": widget.id, "token": Global.userModel?.id}),
        //   ),
        // ),
      )
      ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            print('++++++++++++++++++++++++++++      ${url.split("/").last}');
            print('++++++++++++++++++++++++++++      $url');
            if (url.split("/").last == "success_payment") {
              bottomController.getIndex(3);
              bottomController.setSelectedScreen(true, screenName: AccountScreen());
              setState(() {});
            }
          }));
    return WillPopScope(
      onWillPop: () {
        // bottomController.getIndex(0);
        return bottomController.setSelectedScreen(true, screenName: SubscriptionScreen());
      },
      child: Scaffold(
          appBar: CustomAppBar(
            title: "Check Out",
            // image: MyImages.notification,
            onTap: () {
              bottomController.setSelectedScreen(true, screenName: SubscriptionScreen());
              // Get.to(() => BottomNavigationScreen());
            },
          ),
          body: SafeArea(
            child: WebViewWidget(
              controller: controller,
            ),
          )),
    );
  }
}

// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:fit_gate/bottom_sheet/payment_bottomsheet.dart';
// import 'package:fit_gate/controller/payment_controller.dart';
// import 'package:fit_gate/custom_widgets/custom_app_bar.dart';
// import 'package:fit_gate/custom_widgets/custom_btns/icon_button.dart';
// import 'package:fit_gate/custom_widgets/custom_text_field.dart';
// import 'package:fit_gate/global_functions.dart';
// import 'package:fit_gate/screens/bottom_bar_screens/bottom_naviagtion_screen.dart';
// import 'package:fit_gate/screens/subscription_page.dart';
// import 'package:fit_gate/utils/my_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_tap_payment/flutter_tap_payment.dart';
// import 'package:get/get.dart';
//
// import '../controller/bottom_controller.dart';
// import '../custom_widgets/custom_btns/custom_button.dart';
// import '../custom_widgets/custom_cards/custom_subscriptions_card.dart';
// import '../custom_widgets/custom_cards/subs_plan_card.dart';
// import '../custom_widgets/custom_validation.dart';
// import '../utils/my_images.dart';
//
// class CheckOutPage extends StatefulWidget {
//   final GymPackage? gymPackage;
//   const CheckOutPage({Key? key, this.gymPackage}) : super(key: key);
//
//   @override
//   State<CheckOutPage> createState() => _CheckOutPageState();
// }
//
// class _CheckOutPageState extends State<CheckOutPage> {
//   final bottomController = Get.put(BottomController());
//   final paymentController = Get.put(PaymentController());
//   final TextEditingController name = TextEditingController();
//   final TextEditingController cpr = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     print(
//         'CHECK OUTT PAGE -----------      ${Global.userModel?.name} ${Global.userModel?.middleName} ${Global.userModel?.lastName}');
//     return WillPopScope(
//       onWillPop: () {
//         bottomController.getIndex(0);
//
//         return bottomController.setSelectedScreen(true,
//             screenName: SubscriptionPage());
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: PreferredSize(
//             preferredSize: const Size(double.infinity, kToolbarHeight),
//             child: CustomAppBar(
//               title: "Check Out",
//               // image: MyImages.notification,
//               onTap: () {
//                 bottomController.setSelectedScreen(true,
//                     screenName: SubscriptionPage());
//                 // Get.to(() => BottomNavigationScreen());
//               },
//             )),
//         body: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             FocusManager.instance.primaryFocus?.unfocus();
//           },
//           child: Form(
//             key: formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: ListView(
//                 children: [
//                   CustomSubscriptionCard(
//                     selectedIndex: 0,
//                     gymPackage: widget.gymPackage!,
//                   ),
//                   SizedBox(height: 30),
//                   CustomTextField(
//                     prefixIcon: MyImages.account,
//                     controller: name,
//                     // validator: (name) =>  Validation.nameValidation(name),
//                     hint:
//                         '${Global.userModel?.name == null ? "UserName" : Global.userModel?.name} ${Global.userModel?.middleName == null ? "" : Global.userModel?.middleName} ${Global.userModel?.lastName == null ? "" : Global.userModel?.lastName}',
//                     readOnly: Global.userModel?.name != null ? true : false,
//                     hintColor: Global.userModel?.name != null
//                         ? MyColors.black
//                         : MyColors.grey,
//                     label: "Name",
//                     lblColor: MyColors.black,
//                   ),
//                   SizedBox(height: 7),
//                   CustomTextField(
//                     // keyboardType: TextInputType.number,
//                     prefixIcon: MyImages.privacyPolicy,
//                     controller: cpr,
//                     validator: (input) {
//                       final isDigitsOnly = int.tryParse(input!);
//                       return isDigitsOnly == null
//                           ? 'Please enter valid cpr number'
//                           : null;
//                     },
//                     keyboardType: Platform.isIOS
//                         ? TextInputType.numberWithOptions(
//                             signed: true, decimal: true)
//                         : TextInputType.number,
//                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                     hint: "Enter your CPR number",
//                     label: "CPR",
//                     maxLength: 9,
//                     lblColor: MyColors.black,
//                   ),
//                   SizedBox(height: 30),
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: GetBuilder<PaymentController>(builder: (controller) {
//                       return CustomButton(
//                           height: MediaQuery.of(context).size.height * 0.06,
//                           title: "Proceed to Payment",
//                           fontSize: 18,
//                           onTap: () {
//                             if (formKey.currentState!.validate()) {
//                               print('wwwwwwwwwww');
//                               if (Global.userModel?.name == null &&
//                                   name.text.isEmpty) {
//                                 snackBar("Please fill the details");
//                               } else if (cpr.text.isEmpty) {
//                                 print('qqqqqqqqqqq');
//                                 snackBar("Please enter cpr number");
//                               } else if (cpr.text.length != 9) {
//                                 snackBar("CPR number must be 9 digits");
//                               } else {
//                                 print('eeeeeeeee');
//                                 print(
//                                     "AMOUNTTTT     ----------     ${widget.gymPackage?.price}");
//                                 Get.to(
//                                   () => TapPayment(
//                                       apiKey:
//                                           "sk_test_FEZzfQHgxTPqISms03Bheo47",
//                                       redirectUrl: "https://tap.company",
//                                       postUrl: "https://tap.company",
//                                       paymentData: {
//                                         "amount": widget.gymPackage?.price,
//                                         "currency": "OMR",
//                                         "threeDSecure": true,
//                                         "save_card": false,
//                                         "description": "Test Description",
//                                         "statement_descriptor": "Sample",
//                                         // "term": {
//                                         //   "interval": "MONTHLY",
//                                         //   "period": 10,
//                                         //   "from": "2019-02-20T12:42:00",
//                                         //   "due": 0,
//                                         //   "auto_renew": true,
//                                         //   "timezone": "Asia/Kuwait"
//                                         // },
//                                         // "trial": {"days": 2, "amount": 0.1},
//                                         "metadata": {
//                                           "udf1": "test 1",
//                                           "udf2": "test 2"
//                                         },
//                                         "reference": {
//                                           "transaction": "txn_0001",
//                                           "order": "ord_0001"
//                                         },
//                                         "receipt": {
//                                           "email": false,
//                                           "sms": true
//                                         },
//                                         "customer": {
//                                           "first_name": name.text,
//                                           "middle_name": "test",
//                                           "last_name": "test",
//                                           "email": "test@test.com",
//                                           "phone": {
//                                             "country_code": "+973",
//                                             "number":
//                                                 Global.userModel?.phoneNumber
//                                           }
//                                         },
//                                         // "merchant": {"id": ""},
//                                         "source": {"id": "src_card"},
//                                         // "destinations": {
//                                         //   "destination": [
//                                         //     {"id": "480593777", "amount": 2, "currency": "KWD"},
//                                         //     {"id": "486374777", "amount": 3, "currency": "KWD"}
//                                         //   ]
//                                         // }
//                                       },
//                                       onSuccess: (Map params) async {
//                                         paymentController.payment(
//                                           userId:
//                                               Global.userModel?.id.toString(),
//                                           name: Global.userModel?.name == null
//                                               ? name.text
//                                               : Global.userModel?.name,
//                                           cprNo: cpr.text,
//                                           amount: widget.gymPackage?.price,
//                                           subType: widget.gymPackage?.title,
//                                         );
//                                         log("onSuccess: $params");
//                                         print(
//                                             "USER IDDDDDDD : ${Global.userModel?.id.toString()}");
//                                         print(
//                                             "CLASS TYPEEE ${widget.gymPackage?.title}");
//                                       },
//                                       onError: (error) {
//                                         log("onError: $error");
//                                         snackBar("${error['message']}");
//                                       }),
//                                 );
//                               }
//                             }
//                           }
//                           // snackBar("Please enter the details");
//
//                           );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
