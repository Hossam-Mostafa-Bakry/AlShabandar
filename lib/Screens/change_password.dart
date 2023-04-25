import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mishwar/Screens/login.dart';
import 'package:mishwar/app/Services/UserServices.dart';

import '../lang/app_Localization.dart';
import '../main.dart';

class ChangePasword extends StatefulWidget {
  String phoneNumber;

  ChangePasword({
    this.phoneNumber,
  });

  @override
  State<ChangePasword> createState() => _ChangePaswordState();
}

class _ChangePaswordState extends State<ChangePasword> {
  home h = new home();

  TextEditingController password =  TextEditingController();
  TextEditingController password2 =  TextEditingController();

  final passwordNode = FocusNode();
  final password2Node = FocusNode();
  final formKey = GlobalKey<FormState>();
  String key = "00966";

  bool passVisibility = true;
  bool passVisibility2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DemoLocalizations.of(context).title['change_password'],
        ),
        elevation: 0,
        backgroundColor: Color(h.mainColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              "images/otp.png",
              height: 200,
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(password2Node);
                      },
                      focusNode: passwordNode,
                      obscureText: passVisibility,
                      onChanged: (String value) {
                        // password.text = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return DemoLocalizations.of(context)
                              .title['passowrdrequired'];
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(h.mainColor)),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black45),
                        contentPadding: EdgeInsets.only(
                            right: 15, left: 15, top: 10, bottom: 10),
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(h.borderColor))),
                        focusedBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Color(h.FocusBorderColor))),
                        focusedErrorBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Color(h.ErorrBorderColor))),
                        errorBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Color(h.ErorrBorderColor))),
                        hintText: DemoLocalizations.of(context).title['pass'],
                        prefixIcon: Icon(
                          Icons.https_rounded,
                          size: 20,
                          color: Colors.black45,
                        ),
                        suffixIcon: InkWell(
                          child: Icon(
                            passVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black38,
                          ),
                          onTap: () {
                            setState(() {
                              passVisibility = !passVisibility;
                            });
                          },
                        ),
                      ),
                      controller: password,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      focusNode: password2Node,
                      obscureText: passVisibility2,
                      onChanged: (String value) {
                        // password2.text = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return DemoLocalizations.of(context)
                              .title['confirmnewpasswordrequired'];
                        } else if (value.compareTo(password.text) != 0) {
                          return DemoLocalizations.of(context)
                              .title['confirm_password_error'];
                        } else {
                          return null;
                        }
                        ;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(h.mainColor)),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black45),
                        contentPadding: EdgeInsets.only(
                            right: 15, left: 15, top: 10, bottom: 10),
                        enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(h.borderColor))),
                        focusedBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Color(h.FocusBorderColor))),
                        focusedErrorBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Color(h.ErorrBorderColor))),
                        errorBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Color(h.ErorrBorderColor))),
                        hintText: DemoLocalizations.of(context)
                            .title['confirmnewpassword'],
                        prefixIcon: Icon(
                          Icons.https_rounded,
                          size: 20,
                          color: Colors.black45,
                        ),
                        suffixIcon: InkWell(
                          child: Icon(
                            passVisibility2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black38,
                          ),
                          onTap: () {
                            setState(() {
                              passVisibility2 = !passVisibility2;
                            });
                          },
                        ),
                      ),
                      controller: password2,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                if (formKey.currentState.validate()) {
                  EasyLoading.show();
                  UserServices()
                      .changePassword(widget.phoneNumber, password.text)
                      .then((value) {
                        if(value == true) {
                          EasyLoading.dismiss();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login("login"),));
                        } else {
                          EasyLoading.dismiss();

                        }
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(h.blueColor),
                ),
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .6,
                alignment: Alignment.center,
                child: Text(
                  DemoLocalizations.of(context).title['confirm'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
