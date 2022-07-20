import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'addPass.dart';

TextEditingController Website_Name_Controller = TextEditingController();
TextEditingController EmailId_Controller = TextEditingController();
TextEditingController Password_Controller = TextEditingController();

List<Color> myColors = [
  Colors.amber,
  Colors.blue,
  Colors.blueGrey,
  Colors.cyan,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.green,
  Colors.grey,
  Colors.indigo,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.lime,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.red
];

class Passmanager extends StatefulWidget {
  const Passmanager({Key? key}) : super(key: key);

  @override
  _PassmanagerState createState() => _PassmanagerState();
}

class _PassmanagerState extends State<Passmanager> {
  Box<String> PasswordBox = Hive.box<String>("PasswordVault");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PasswordBox = Hive.box<String>("PasswordVault");
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff17181C),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          backgroundColor: Colors.transparent,
          title: Text('Your Passwords',
              style: GoogleFonts.montserrat(fontSize: 25)),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff3E00FF),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    child: Container(
                      color: Color(0xff17181C),
                      height: h / 2,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: TextField(
                              keyboardType: TextInputType.url,
                              textAlign: TextAlign.center,
                              controller: Website_Name_Controller,
                              decoration: InputDecoration(hintText: "Website"),
                            ),
                          ),
                          SizedBox(
                            height: h / 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              controller: EmailId_Controller,
                              decoration:
                                  InputDecoration(hintText: "Email - id"),
                            ),
                          ),
                          SizedBox(
                            height: h / 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: TextField(
                              keyboardType: TextInputType.url,
                              textAlign: TextAlign.center,
                              controller: Password_Controller,
                              decoration: InputDecoration(hintText: "Password"),
                            ),
                          ),
                          SizedBox(
                            height: h / 15,
                          ),
                          FloatingActionButton(
                              backgroundColor: Color(0xff3E00FF),
                              onPressed: () {
                                String key = Website_Name_Controller.text +
                                    '@mySeperator@' +
                                    EmailId_Controller.text;
                                String value = Password_Controller.text;
                                print('key = $key');
                                print('value = $value');
                                if (Website_Name_Controller.text.length == 0 &&
                                    EmailId_Controller.text.length == 0) {
                                  Navigator.pop(context);
                                } else {
                                  PasswordBox.put(key, value);

                                  Website_Name_Controller.clear();
                                  Password_Controller.clear();
                                  EmailId_Controller.clear();

                                  Navigator.pop(context);
                                }
                              },
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: PasswordBox.listenable(),
              builder: (context, Box<String> Passwords, _) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      int ColorNum = index % 10;
                      String key = Passwords.keys.toList()[index];
                      List<String> MyList = key.split('@mySeperator@');
                      String Website = MyList[0];
                      print('List =  $MyList');
                      String Id = MyList[1];
                      String value = PasswordBox.get(key)!;
                      return ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                child: Container(
                                  color: Color(0xff17181C),
                                  padding: EdgeInsets.all(8),
                                  height: h / 2.5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Website',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white60),
                                            ),
                                            Text(
                                              Website,
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Email - Id',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white60),
                                            ),
                                            Text(
                                              Id,
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Password',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white60),
                                            ),
                                            Text(
                                              value,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: h / 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              String OldKey = key;
                                              TextEditingController
                                                  Update_Website_Name_Controller =
                                                  TextEditingController(
                                                      text: Website);
                                              TextEditingController
                                                  Update_EmailId_Controller =
                                                  TextEditingController(
                                                      text: Id);
                                              TextEditingController
                                                  Update_Password_Controller =
                                                  TextEditingController(
                                                      text: value);
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return Dialog(
                                                      child: Container(
                                                        color:
                                                            Color(0xff17181C),
                                                        height: h / 1.8,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8,
                                                                vertical: 5),
                                                        child: Column(
                                                          children: [
                                                            Text('Tap to Edit'),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2),
                                                              child: TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .url,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                controller:
                                                                    Update_Website_Name_Controller,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: h / 15,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      2),
                                                              child: TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .emailAddress,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                controller:
                                                                    Update_EmailId_Controller,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: h / 15,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      2),
                                                              child: TextField(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                controller:
                                                                    Update_Password_Controller,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: h / 15,
                                                            ),
                                                            FloatingActionButton(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xff3E00FF),
                                                                onPressed: () {
                                                                  String key = Update_Website_Name_Controller
                                                                          .text +
                                                                      '@mySeperator@' +
                                                                      Update_EmailId_Controller
                                                                          .text;
                                                                  String value =
                                                                      Update_Password_Controller
                                                                          .text;
                                                                  if (key !=
                                                                      OldKey) {
                                                                    PasswordBox
                                                                        .put(
                                                                            key,
                                                                            value);
                                                                    Passwords
                                                                        .delete(
                                                                            OldKey);
                                                                  } else {
                                                                    PasswordBox
                                                                        .put(
                                                                            key,
                                                                            value);
                                                                  }

                                                                  Website_Name_Controller
                                                                      .clear();
                                                                  Password_Controller
                                                                      .clear();
                                                                  EmailId_Controller
                                                                      .clear();

                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .white,
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Icon(Icons.edit),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              PasswordBox.delete(key);
                                              Navigator.pop(context);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        leading: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          child: Text(
                            key[0].toUpperCase(),
                            style: GoogleFonts.roboto(
                              fontSize: 25,
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: myColors[ColorNum]),
                        ),
                        title: Text(Website),
                        trailing: InkWell(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: value));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Password Copied"),
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
                              setState(() {});
                            },
                            child: Icon(Icons.copy_outlined)),
                      );
                    },
                    separatorBuilder: (_, index) => Divider(),
                    itemCount: Passwords.keys.toList().length);
              },
            ))
          ],
        ));
  }
}




// Container(
//                         child: Column(
//                           children: [
//                             Text(Website),
//                             Text(Id),
//                             Text(value),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 FloatingActionButton(
//                                   onPressed: () {
//                                     String OldKey = key;
//                                     TextEditingController
//                                         Update_Website_Name_Controller =
//                                         TextEditingController(text: Website);
//                                     TextEditingController
//                                         Update_EmailId_Controller =
//                                         TextEditingController(text: Id);
//                                     TextEditingController
//                                         Update_Password_Controller =
//                                         TextEditingController(text: value);
//                                     showDialog(
//                                         context: context,
//                                         builder: (_) {
//                                           return Dialog(
//                                             child: Container(
//                                               height: h / 2,
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 8, vertical: 5),
//                                               child: Column(
//                                                 children: [
//                                                   TextField(
//                                                     controller:
//                                                         Update_Website_Name_Controller,
//                                                   ),
//                                                   SizedBox(
//                                                     height: h / 15,
//                                                   ),
//                                                   TextField(
//                                                     controller:
//                                                         Update_EmailId_Controller,
//                                                   ),
//                                                   SizedBox(
//                                                     height: h / 15,
//                                                   ),
//                                                   TextField(
//                                                     controller:
//                                                         Update_Password_Controller,
//                                                   ),
//                                                   SizedBox(
//                                                     height: h / 15,
//                                                   ),
//                                                   FloatingActionButton(
//                                                       onPressed: () {
//                                                         String key =
//                                                             Update_Website_Name_Controller
//                                                                     .text +
//                                                                 '@mySeperator@' +
//                                                                 Update_EmailId_Controller
//                                                                     .text;
//                                                         String value =
//                                                             Update_Password_Controller
//                                                                 .text;

//                                                         PasswordBox.put(
//                                                             key, value);
//                                                         Website_Name_Controller
//                                                             .clear();
//                                                         Password_Controller
//                                                             .clear();
//                                                         EmailId_Controller
//                                                             .clear();
//                                                         Passwords.delete(
//                                                             OldKey);
//                                                         Navigator.pop(context);
//                                                       },
//                                                       child: Icon(Icons.check))
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         });
//                                   },
//                                   child: Icon(Icons.edit),
//                                 ),
//                                 SizedBox(width: 20),
//                                 FloatingActionButton(
//                                     onPressed: () {
//                                       PasswordBox.delete(key);
//                                     },
//                                     child: Icon(Icons.delete)),
//                               ],
//                             )
//                           ],
//                         ),
//                       );