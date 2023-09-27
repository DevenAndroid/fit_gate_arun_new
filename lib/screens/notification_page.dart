import 'package:fit_gate/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/notification_controller.dart';
import '../custom_widgets/custom_app_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notifyController = Get.put(NotificationController());
  // final loginController = Get.put(LoginController());
  // final bottomCon = Get.put(BottomController());
  //
  // getNotify() async {
  //   await notifyController.notification();
  //   await loginController.getUserById();
  // }

  // @override
  // void initState() {
  //   getNotify();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Notification",
          image: "",
          onTap: () {
            notifyController.countNotification();
            Get.back();
          }),
      body: GetBuilder<NotificationController>(builder: (controller) {
        return controller.notificationList.isEmpty
            ? Center(child: Text("You don't have notification"))
            : ListView.separated(
                itemCount: controller.notificationList.length,
                itemBuilder: (c, i) {
                  var data = controller.notificationList[i];
                  // String bin = data.createdAt.toString();
                  // var format = bin.substring(bin.length - 8);
                  // var time = DateFormat.jm()
                  //     .format(DateFormat("hh:mm:ss").parse("$format"));
                  return InkWell(
                    onTap: () async {
                      notifyController.updateNotification(notifyId: data.id);
                      setState(() {});
                      data.status = '1';
                      // await notifyController.notification();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data.tittle}",
                            style: TextStyle(
                              color: data.status == '0'
                                  ? MyColors.orange.withOpacity(0.9)
                                  : MyColors.orange,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${data.message}",
                            style: TextStyle(
                              fontSize: 15,
                              color: data.status == '0'
                                  ? MyColors.blue
                                  : MyColors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 5),
                          // Spacer(),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text("${data.createdAt ?? ""}")),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 1,
                  endIndent: 12,
                  indent: 12,
                ),
              );
      }),
    );
  }
}
