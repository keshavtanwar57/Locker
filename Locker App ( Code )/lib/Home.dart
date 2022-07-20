import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'myrandomNum.dart';
import 'package:flutter/services.dart';
import 'passwordmanager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:lottie/lottie.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Box<String> UserBox = Hive.box<String>("UserData");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserBox = Hive.box<String>("UserData");
  }

  String password = '';
  int length = 0;
  double rating1 = 0;
  Color NumberColor = Colors.deepPurpleAccent;
  Color UpperColor = Colors.deepPurpleAccent;
  Color LowerColor = Colors.deepPurpleAccent;
  Color SpecialColor = Colors.deepPurpleAccent;
  bool upper = true;
  bool lower = true;
  bool nums = true;
  bool special = true;
  String BiometricButtonText = 'Enable';
  int SliderLength = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 1.5;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showMaterialModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => Container(
                height: h / 4.7,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black87),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Passmanager()),
                        );
                      },
                      child: Container(
                        width: w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'Password Manager',
                          style: GoogleFonts.roboto(fontSize: 23),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        if (UserBox.get('BiometricEnable') == 'false') {
                          UserBox.put('BiometricEnable', 'true');
                        } else {
                          UserBox.put('BiometricEnable', 'false');
                        }
                        String message =
                            UserBox.get('BiometricEnable') == 'true'
                                ? 'Biometric Enabled'
                                : 'Biometric Disabled';

                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(message),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {
                              print('Action is clicked');
                            },
                            textColor: Colors.black87,
                            disabledTextColor: Colors.grey,
                          ),
                        ));
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'Biometrics',
                          style: GoogleFonts.roboto(fontSize: 23),
                        ),
                      ),
                    ),
                    Divider(),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Transform.rotate(
                        angle: 0,
                        child: Column(
                          children: [
                            Expanded(
                                child:
                                    LottieBuilder.asset('assets/arrow.json')),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            );
          },
          child: Transform.rotate(
            angle: 135,
            child: Column(
              children: [
                Expanded(child: LottieBuilder.asset('assets/arrow.json')),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Color(0xff17181C),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Password Generator',
            style: GoogleFonts.montserrat(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Set Password Length'),
              ),
              SliderTheme(
                child: Slider(
                  min: 0.0,
                  max: 31,
                  value: rating1,
                  onChanged: (newRating) {
                    setState(() {
                      rating1 = newRating;
                      length = (newRating).round();
                      SliderLength = length;
                    });
                  },
                  label: "$length",

                  //activeColor: Color(0xff3E00FF),
                ),
                data: SliderThemeData(
                    activeTrackColor: length <= 8
                        ? Colors.red
                        : length <= 15
                            ? Colors.yellow
                            : length <= 25
                                ? Colors.green
                                : Color(0xff3E00FF),
                    thumbColor: Color(0xff3E00FF)),
              ),
              Text(length.toString()),
              SizedBox(
                height: h / 25,
              ),
              InkWell(
                onTap: () {
                  NumberColor == Colors.deepPurpleAccent
                      ? NumberColor = Colors.grey
                      : NumberColor = Colors.deepPurpleAccent;
                  nums == false ? nums = true : nums = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Numbers',
                    style: TextStyle(fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: NumberColor),
                ),
              ),
              SizedBox(
                height: h / 24,
              ),
              InkWell(
                onTap: () {
                  UpperColor == Colors.deepPurpleAccent
                      ? UpperColor = Colors.grey
                      : UpperColor = Colors.deepPurpleAccent;
                  upper == false ? upper = true : upper = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Upper Case',
                    style: TextStyle(fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: UpperColor),
                ),
              ),
              SizedBox(
                height: h / 24,
              ),
              InkWell(
                onTap: () {
                  LowerColor == Colors.deepPurpleAccent
                      ? LowerColor = Colors.grey
                      : LowerColor = Colors.deepPurpleAccent;
                  lower == false ? lower = true : lower = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Lower Case',
                    style: TextStyle(fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: LowerColor),
                ),
              ),
              SizedBox(
                height: h / 24,
              ),
              InkWell(
                onTap: () {
                  SpecialColor == Colors.deepPurpleAccent
                      ? SpecialColor = Colors.grey
                      : SpecialColor = Colors.deepPurpleAccent;
                  special == false ? special = true : special = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Special Character',
                    style: TextStyle(fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: SpecialColor),
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              Text(
                password,
                style: GoogleFonts.mPlusRounded1c(fontSize: 20),
              ),
              SizedBox(
                height: h / 30,
              ),
              InkWell(
                onTap: () {
                  if (SliderLength == 0) {
                    password = '';
                  } else if (SliderLength < 4) {
                    password = '';
                  } else {
                    password = Password(nums, upper, lower, special, length);
                  }

                  String mssg = SliderLength == 0
                      ? 'Please set Passowrd length'
                      : nums == false &&
                              upper == false &&
                              lower == false &&
                              special == false
                          ? 'Please select Password type'
                          : SliderLength >= 4
                              ? 'Password Generated'
                              : 'Password is too weak increase the Password length';

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(mssg),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        print('Action is clicked');
                      },
                      textColor: Colors.black87,
                      disabledTextColor: Colors.grey,
                    ),
                  ));

                  setState(() {});
                },
                child: Container(
                  width: w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xff3E00FF),
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "Generate",
                    style: GoogleFonts.montserrat(fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: password));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Password Copied"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        print('Action is clicked');
                      },
                      textColor: Colors.black87,
                      disabledTextColor: Colors.grey,
                    ),
                  ));
                  setState(() {});
                },
                child: Container(
                  width: w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xff2D2E37),
                      borderRadius: BorderRadius.circular(100)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "Copy",
                    style: GoogleFonts.montserrat(
                        fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
