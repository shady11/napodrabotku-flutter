import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ishapp/screens/verification_code_screen.dart';
import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/svg_icon.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _numberController = TextEditingController();
  String _countryCode = '+1'; // +1 US

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Phone Number"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: SvgIcon("assets/icons/call_icon.svg",
                    width: 60, height: 60, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text("Sign in with Phone Number",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
              SizedBox(height: 25),
              Text(
                  "Please enter your phone Number and we will send you a SMS verification code",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 22),

              /// Form
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _numberController,
                      decoration: InputDecoration(
                          labelText: "Phone number",
                          hintText: "Enter your number",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CountryCodePicker(
                                initialSelection: 'US',
                                onChanged: (country) {
                                  /// Get country code
                                  _countryCode = country.dialCode;
                                }),
                          )),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      validator: (number) {
                        // Basic validation
                        if (number.isEmpty) {
                          return "Please enter your phone number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.maxFinite,
                      child: DefaultButton(
                        child: Text("Continue", style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          /// Get valid phone number with country code
                          final String phoneNumber =
                              _countryCode + _numberController.text;

                          // Debug
                          print(phoneNumber);

                          /// Validate form
                          // if (_formKey.currentState.validate()) {
                          // }

                          /// Go to verification code screen - for demo
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => 
                               VerificationCodeScreen()));
                               
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
