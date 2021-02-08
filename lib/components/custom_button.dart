import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double elevation;
  final int borderRadius;
  final EdgeInsets padding;
  final double textSize;
  final Color color;
  final Color textColor;
  final width;
  final height;

  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.textSize,
    this.color,
    this.textColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.4,
      height: height ?? 50.0,
      child: RawMaterialButton(
        onPressed: onPressed,
        elevation: elevation ?? 0,
        fillColor:color ?? kColorBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10)),
        child: Padding(
          padding: padding ??
              const EdgeInsets.only(top: 9, bottom: 10, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: Theme.of(context).textTheme.button.copyWith(
                    color: textColor ?? Colors.white,
                    fontSize:
                        textSize ?? Theme.of(context).textTheme.button.fontSize,
                    fontFamily: 'GTEestiProDisplay'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
