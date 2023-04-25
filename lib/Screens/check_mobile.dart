import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Services/snackbar_service.dart';
import 'package:mishwar/app/Services/UserServices.dart';
import 'package:mishwar/main.dart';
import 'package:provider/provider.dart';

import '../app/Services/UserServices.dart';
import '../lang/app_Localization.dart';
import 'GlobalFunction.dart';
import 'Verification.dart';
import 'otp_provider.dart';

class CheckMobile extends StatefulWidget {
  @override
  State<CheckMobile> createState() => _CheckMobileState();
}

class _CheckMobileState extends State<CheckMobile> {
  home h = home();

  TextEditingController phoneController = TextEditingController();

  UserServices _services = UserServices();

  // String countryKey = "+966";
  var key = "00966";

  Map<String, dynamic> data;

  UserServices userServices = new UserServices();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("check Mobile"),
          elevation: 0,
          backgroundColor: Color(h.mainColor),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView(
              children: [
                SizedBox(height: 80),
                Image.asset("images/otp.png", height: 180),
                SizedBox(height: 80),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (value) {
                            // FocusScope.of(context).requestFocus(passwordNode);
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
                                  borderSide:
                                      BorderSide(color: Color(h.borderColor))),
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
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .26,
                        height: 47,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            width: 1,
                            color: Color(h.borderColor),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .01,
                            right: MediaQuery.of(context).size.width * .01),
                        child: Container(
                          alignment: Alignment.center,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: CountryCodePicker(
                              alignLeft: false,
                              flagWidth: 35,
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
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    // if (phoneController.text.substring(0, 1) == "0") {
                    //   setState(() {
                    //     phoneController.text = phoneController.text.substring(1);
                    //   });
                    // };
                    debugPrint("${phoneController.text}");

                    var result =
                        await _services.checkMobile(phoneController.text);
                    // data = await userServices.sentOTP(key + phoneController.text);

                    debugPrint("data: $result");
                    debugPrint("mobile number: ${phoneController.text}");

                    if (result == true) {
                      Navigator.pushReplacement(
                        context,
                        GlobalFunction.routeBottom(
                          ChangeNotifierProvider(
                            create: (context) => OTPProvider(),
                            child: verification(
                              "register",
                              phoneController.text,
                            ),
                          ),
                        ),
                      );
                    } else if (result == false) {
                      SnackBarService.showErrorMessage(
                        DemoLocalizations.of(context)
                            .title['yourPhoneExisting'],
                      );

                      debugPrint("error");
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      DemoLocalizations.of(context).title['checkMobile'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
