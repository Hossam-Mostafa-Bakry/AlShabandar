import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/app/Services/UserServices.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mishwar/lang/app_Localization.dart';
import '../Services/snackbar_service.dart';
import '../main.dart';
import 'GlobalFunction.dart';
import 'Verification.dart';
import 'otp_provider.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<ForgetPassword> {
  String error;
  var key = "00966";
  bool isError = false;
  UserServices userServices = new UserServices();
  home h = new home();
  bool passVisibility = true;
  final passwordNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Map<String, dynamic> responce;

  Map<String, dynamic> data;
  var result;

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(h.whiteColor),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .05,
              right: MediaQuery.of(context).size.width * .05),
          child: ListView(
            //margin:
            //child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .17,
              ),
              Image.asset(
                "images/logo.png",
                height: MediaQuery.of(context).size.height * .23,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    DemoLocalizations.of(context).title['codewillbesent'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 27,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .62,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(passwordNode);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return DemoLocalizations.of(context)
                                      .title['phonerequired'];
                                }
                                return null;
                              },
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(h.mainColor)),
                                  contentPadding: EdgeInsets.only(
                                      right: 10, left: 10, top: 0, bottom: 0),
                                  enabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.borderColor))),
                                  focusedBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.FocusBorderColor))),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))),
                                  errorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    size: 20,
                                    color: Colors.black45,
                                  ),
                                  hintText: '05XXXXXXX',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black45)),
                              controller: username,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * .26,
                              height: 47,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1,
                                    color: isError
                                        ? Color(h.ErorrBorderColor)
                                        : Color(h.borderColor)),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * .01,
                                  right:
                                      MediaQuery.of(context).size.width * .01),
                              child: Container(
                                //width: MediaQuery.of(context).size.width*.22,
                                alignment: Alignment.center,
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: CountryCodePicker(
                                    alignLeft: false,
                                    padding: EdgeInsets.zero,
                                    onChanged: (v) {
                                      setState(() {
                                        key = v.toString();
                                      });
                                      print(key);
                                    },
                                    dialogTextStyle: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                    hideMainText: false,
                                    showFlagMain: true,
                                    showFlag: true,
                                    initialSelection: 'SA',
                                    hideSearch: false,
                                    textStyle: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                    favorite: ["EG", "SA"],
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              error == null
                  ? SizedBox()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(
                        error,
                        style: TextStyle(
                          color: Color(h.ErorrBorderColor),
                          fontSize: 12,
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async => {
                  if (formKey.currentState.validate())
                    {
                      // if (username.text.substring(0, 1) == "0")
                      //   {
                      //     setState(() {
                      //       username.text = username.text.substring(1);
                      //     }),
                      //   },

                      result = await userServices.checkMobile(username.text),

                      if (result == false)
                        {
                          Navigator.pushReplacement(
                            context,
                            GlobalFunction.routeBottom(
                              ChangeNotifierProvider(
                                create: (context) => OTPProvider(),
                                child: verification(
                                  "forget",
                                  username.text,
                                  // otp: data["item2"],
                                  // name: name.text,
                                  // email: email.text,
                                  // password: password.text,
                                ),
                              ),
                            ),
                          ),

                          // debugPrint("----------------------------------------"),
                          // debugPrint("otp : ${data["item2"]}"),
                        }
                      else if (result == true)
                        {
                          SnackBarService.showErrorMessage(
                            DemoLocalizations.of(context).title['not_existing'],
                          ),
                          debugPrint("error"),
                        }
                      // if (responce["StatusCode"] == 200)
                      //   Navigator.push(
                      //       context,
                      //       GlobalFunction.route(verification(
                      //         "Forget",
                      //         responce["Message"]["phone"],
                      //       )))
                      // else
                      //   {
                      //     setState(() {
                      //       error = responce["Message"];
                      //       isError = false;
                      //     }),
                      //   }
                    }
                  else
                    {
                      setState(() {
                        isError = true;
                      })
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
            ],
            //  ),
          ),
        ),
      ),
    );
  }

  setData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
