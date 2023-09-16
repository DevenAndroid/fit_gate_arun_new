import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom_widgets/dialog/custom_dialog.dart';
import '../../global_functions.dart';
import '../../repo/userinfo_repo.dart';
import '../bottom_bar_screens/bottom_naviagtion_screen.dart';
import 'login_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String dropdownvalue = 'Select Country';
  String dropdowngender = 'Select Gender';
  String dropdownBahrain = 'Select Area';
  String dropdownSaudiArabia = 'Select Area';

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  DateTime current = DateTime.now().subtract(Duration(days: 365*18));

  pickDate({required Function(DateTime gg) onPick, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: current,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    if (pickedDate == null) return;
    onPick(pickedDate);
    // updateValues();
  }

  var items = [
    'Select Country',
    'Bahrain',
    'Saudi Arabia',
  ];
  var genderList = [
    'Select Gender',
    'Male',
    'Female',
  ];
  var Bahrain = [
    'Select Area',
    'Hamad Town',
    'Riffa',
    "Askar",
    "Sanad",
    "Hamala",
    "Manama",
    "Seef district",
    "Sitra",
    "Isa town",
    "Zallaq",
    "Saar",
    "Madinat salman",
    "Barbar",
    "Sannabis",
    "Awali",
    "Jidhafs",
    "Malikya",
    "Zinj",
    "Budaiya",
    "Muharraq ",
  ];
  var SaudiArabia = [
    'Select Area',
    "Al-Shargeya",
    "Mecca",
    "Almadina",
    "Al-Jouf",
    "Tabouk",
    "Hai’l",
    "Al-Riyadh",
    "Al-Qassim",
    "Najran",
    "Jazan",
    "Al-baha",
    "Alhodud Al-Shamaleya",
    "Aseer",
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0a65a5),
        title: Text('User Information'),
        actions: [
          IconButton(onPressed: (){
            setState(() {});
            showDialog(
                context: context,
                builder: (_) => CustomDialog(
                  title:
                  "Are sure you want to logout?",
                  label1: "Yes",
                  label2: "No",
                  cancel: () {
                    Get.back();
                  },
                  onTap: () async {
                    await FirebaseAuth.instance
                        .signOut();
                    var pref =
                    await SharedPreferences
                        .getInstance();
                    await pref.setBool(
                        "isLogout", true);
                    await pref.remove('isLogin');
                    await pref
                        .remove('isActivated');
                    Global.userModel = null;
                    Global.activeSubscriptionModel =
                    null;
                    push(
                        context: context,
                        screen: LoginScreen(),
                        pushUntil: true);
                  },
                ));
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    hintText: "First Name",
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(

                  value: dropdowngender,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: genderList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? genderValue) {
                    setState(() {
                      dropdowngender = genderValue!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Select Gender",
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              TextField(
                  controller: dobController,
                  readOnly: true,
                  onTap: (){
                    pickDate(onPick: (DateTime gg) {
                      // 2023-08-03
                      current = gg;
                      dobController.text = DateFormat("yyyy-MM-dd").format(gg);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Date of birth (پیدائش کی تاریخ)",
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Select Country",
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              if (dropdownvalue == "Bahrain")
                DropdownButtonFormField(
                    value: dropdownBahrain,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: Bahrain.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownBahrain = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Select Area",
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                    )),
              if (dropdownvalue == "Saudi Arabia")
                DropdownButtonFormField(
                    value: dropdownSaudiArabia,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: SaudiArabia.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownSaudiArabia = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Select Area",
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                    )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    firstnameController.text.trim();
                    print(await header);

                    SharedPreferences sharedpre = await SharedPreferences.getInstance();
                    String? token = await FirebaseMessaging.instance.getToken();
                    userinfoRepo(
                      country_name: dropdownvalue,
                      dob: dobController.text.trim(),
                      gender: dropdowngender,
                      fname: firstnameController.text.trim(),
                      lname: lastnameController.text.trim(),
                      area: dropdownvalue == "Bahrain" ? dropdownBahrain : dropdownSaudiArabia,
                      fcm_token: token,
                    ).then((value) {
                      if(value.statusCode == 200){
                        FirebaseAuth.instance.currentUser!.updateDisplayName("true");
                        FirebaseAuth.instance.currentUser!.updatePhotoURL(dropdownvalue);
                        Get.offAll(()=> BottomNavigationScreen());
                      }
                    });
                  },
                  child: FirebaseAuth.instance.currentUser!.displayName.toString() != "true" ? Text('Register') : Text('Update'))
            ],
          ),
        ),
      ),
    );
  }
}
