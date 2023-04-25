import 'dart:io';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mishwar/app/Services/GlobalVariables.dart';
import 'package:mishwar/app/Services/UserServices.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../app/AppConfig.dart';
import '../main.dart';
import 'GlobalFunction.dart';
import 'HomePage.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return editProfileState();
  }
}

class editProfileState extends State<EditProfile> {
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final phoneNode = FocusNode();
  final locationNode = FocusNode();
  final birthNode = FocusNode();
  bool passVisibility = true;
  final formKey = GlobalKey<FormState>();
  home h = new home();

  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController date = new TextEditingController();
  var UserId;
  UserServices userServices = new UserServices();
  Map<String, dynamic> data;
  SharedPreferences prefs;
  UserServices _userServices = UserServices();

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    data = await userServices.getUserData(prefs.getString("UserId"));
    name.text = data["name"];
    phone.text = data["phone"];
    email.text = data["email"];
    setState(() {
      UserId = prefs.getString("UserId");
    });
    print(data);
    print("000000000000000");
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    email.dispose();
    phone.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(h.mainColor),
        centerTitle: true,
        title: Text(
          DemoLocalizations.of(context).title['personaldata'],
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: DemoLocalizations.of(context).locale == Locale("en")
                ? Icon(Icons.arrow_back_ios_rounded,
                    size: 25, color: Colors.black)
                : Icon(Icons.arrow_forward_ios_rounded,
                    size: 25, color: Colors.black)),
        actions: [
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                //save
                DemoLocalizations.of(context).title['save'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            onTap: () async {
              if (formKey.currentState.validate()) {
                if (phone.text.substring(0, 1) == "0") {
                  setState(() {
                    phone.text = phone.text.substring(1);
                  });
                }
                ;
                Map<String, dynamic> responce = await userServices
                    .updateProfile(UserId, name.text, email.text, phone.text);
                if (responce["StatusCode"] == 200)
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/mainPage", (route) => false);
                else {
                  Toast.show("${responce["Message"]}", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                }
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * .05,
              left: MediaQuery.of(context).size.width * .05,
              //top: MediaQuery.of(context).size.height * .03
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        pickImage(context);
                      },
                      child: Image.asset(
                        "images/Photo.png",
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .2,
                      ),
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * .14,
                        left: MediaQuery.of(context).size.width * .53,
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xff00e096)),
                          child: Center(
                            child: GestureDetector(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(h.borderColor)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(
                              DemoLocalizations.of(context).title['username'],
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(passwordNode);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return DemoLocalizations.of(context)
                                        .title['usernamerequired'];
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      right: 15, left: 15, top: 10, bottom: 10),
                                  border: InputBorder.none,
                                ),
                                controller: name,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black54,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .017,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(h.borderColor)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(
                              DemoLocalizations.of(context).title['phone'],
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(emailNode);
                                },
                                focusNode: phoneNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    //phonerequired
                                    return DemoLocalizations.of(context)
                                        .title['phonerequired'];
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: phone,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black54,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .017,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(h.borderColor)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                DemoLocalizations.of(context).title['email'],
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                focusNode: emailNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return DemoLocalizations.of(context)
                                        .title['emailrequired'];
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      right: 15, left: 15, top: 10, bottom: 10),
                                  border: InputBorder.none,
                                ),
                                controller: email,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black54,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      DeleteAccount(context);
                    },
                    child: Text(
                      DemoLocalizations.of(context)
                          .title['areyouwanttodeleteaccount'],
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(h.mainColor)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  DeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 150.0,
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.black12,width: 2.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/icon/about.png",
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        DemoLocalizations.of(context).title['deleteacount'],
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(h.blueColor)),
                            height: MediaQuery.of(context).size.height * .045,
                            width: MediaQuery.of(context).size.width * .33,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context).title['cancel'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(h.mainColor)),
                            height: MediaQuery.of(context).size.height * .045,
                            width: MediaQuery.of(context).size.width * .33,
                            alignment: Alignment.center,
                            child: Text(
                              DemoLocalizations.of(context).title['confirm'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          onTap: () async {

                            await _userServices.deleteAccount(prefs.getString("UserId"));
                            clearData();
                            Navigator.push(
                                context, GlobalFunction.route(HomePage()));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  clearData() async {
    //  appConfig.prefs.remove('chooselang');
    appConfig.prefs.remove("UserId");
    appConfig.prefs.remove('delmethodtext');
    appConfig.prefs.remove('delcost'); //delmethodvalue
    appConfig.prefs.remove('delmethodvalue');
    appConfig.prefs.remove('paymethodtext');
    //paymethodvalue
    appConfig.prefs.remove('paymethodvalue');
  }

  File selectedImage;

  pickImage(BuildContext context) async {
    XFile profileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(profileImage.path);
    });
    sendImagePick(selectedImage, context);
  }

  sendImagePick(File fileImage, BuildContext context) async {
    if (fileImage != null) {
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        Dio dio = Dio();

        ///we used uri.encode to enable upload  image with arabic name
        // var url =Uri.encodeFull(createPath('user/editProfileImage'));
        var url = "${GlobalVariables.URL}/user/changeAvatar";
        print(url);
        String fileName = basename(fileImage.path);
        // print('${fileName},,,,fileName');
        //print('${pathImage.path},,,,imagePath.path');

        FormData formData = FormData.fromMap({
          "avatar": await MultipartFile.fromFile(fileImage.path,
              filename: fileName,
              contentType: MediaType('image', fileName.split('.').last)),
          "user_id": int.parse(
              UserId) /*int.parse(sharedPreferences.getString('UserID'))*/,
        });
        print(formData.fields);
        print("ssssssssssssssssss");
        Response response = await dio.post(url, data: formData);
        print('${response.data},,,,,,,,fields');
        if (response.statusCode == 200) {
          Map<String, dynamic> map = response.data;
          Toast.show(map['Data'], context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          loadData();
        } else {
          return null;
        }
      } catch (e) {
        print('${e}imageuploaderror');
      }
    } else {
      pickImage(context);
    }
  }
}
