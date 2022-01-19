import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductLabSignIn extends StatefulWidget {
  const ProductLabSignIn({Key key}) : super(key: key);

  @override
  _ProductLabSignInState createState() => _ProductLabSignInState();
}

class _ProductLabSignInState extends State<ProductLabSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign_in_title".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "select_mode".tr(),
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
