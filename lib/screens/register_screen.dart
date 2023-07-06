import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:questanaire_app/widgets/custom_button.dart';
import '../responsive/responsive.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  Country selctedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: R.sh(24, context),
              horizontal: R.sw(36, context),
            ),
            child: Column(
              children: [
                Container(
                  width: R.sw(200, context),
                  height: R.sh(200, context),
                  padding: EdgeInsets.all(R.sw(20, context)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.shade50,
                  ),
                  child: Image.asset(
                    "assets/images/image2.png",
                  ),
                ),
                SizedBox(height: R.sh(20, context)),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: R.sw(22, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: R.sh(10, context)),
                Text(
                  "Add your phone number. We'll send you a verification code",
                  style: TextStyle(
                    fontSize: R.sw(14, context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: R.sh(20, context)),
                TextFormField(
                  cursorColor: Colors.purple,
                  controller: phoneController,
                  style: TextStyle(
                    fontSize: R.sw(18, context),
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: R.sw(14, context),
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    prefixIcon: Container(
                      padding: EdgeInsets.all(R.sw(8.0, context)),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                                bottomSheetHeight: R.sh(600, context)),
                            onSelect: (value) {
                              setState(() {
                                selctedCountry = value;
                              });
                            },
                          );
                        },
                        child: Text(
                          "${selctedCountry.flagEmoji}  +${selctedCountry.phoneCode}",
                          style: TextStyle(
                            fontSize: R.sw(18, context),
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: phoneController.text.length == 9
                        ? Container(
                      height: R.sh(30, context),
                      width: R.sw(30, context),
                      margin: EdgeInsets.all(R.sw(10.0, context)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: R.sw(20, context),
                      ),
                    )
                        : null,
                  ),
                ),
                SizedBox(height: R.sh(20.0, context)),
                CustomButton(
                  onPressed: () {},
                  text: "Register",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}