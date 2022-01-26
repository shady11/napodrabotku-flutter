import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ishtapp/utils/constants.dart';
import 'package:ishtapp/components/custom_button.dart';
import 'package:ishtapp/routes/routes.dart';
import 'package:ishtapp/datas/pref_manager.dart';

class ProductLabStart extends StatefulWidget {
  const ProductLabStart({Key key}) : super(key: key);

  @override
  _ProductLabStartScreenState createState() => _ProductLabStartScreenState();
}

class _ProductLabStartScreenState extends State<ProductLabStart> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Image.asset(
                    'assets/images/welcome.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Sign in with Phone Number
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    padding: EdgeInsets.all(10),
                    color: Color(0xffF2F2F5),
                    textColor: kColorBlue,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.product_lab_sign_up);
                    },
                    text: 'sign_up'.tr(),
                  ),
                  CustomButton(
                    padding: EdgeInsets.all(10),
                    color: kColorPrimary,
                    textColor: Colors.white,
                    onPressed: () {
                      Prefs.setString(Prefs.ROUTE, "PRODUCT_LAB");
                      Navigator.of(context).pushNamed(Routes.signin);
                    },
                    text: 'sign_in'.tr(),
                  ),
                ],
              ),

              SizedBox(height: 10),

              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('guest'.tr(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                ),
                onTap: () {
                  // Navigator.of(context).pushNamed(Routes.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
