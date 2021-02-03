import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  // Variables
  final Widget icon;
  final String text;

  const Badge({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, //.withAlpha(85),
          borderRadius: BorderRadius.circular(20.0)),
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? Container(width: 0, height: 0),
          icon != null ? SizedBox(width: 10) : Container(width: 0, height: 0),
          Text(text ?? "", style: TextStyle(color: Colors.white)),
        ],
      ));
  }
}
