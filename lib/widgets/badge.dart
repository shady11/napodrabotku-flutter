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
          borderRadius: BorderRadius.circular(15.0)),
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? Container(width: 0, height: 0),
          icon != null ? SizedBox(width: 5) : Container(width: 0, height: 0),
          Text(text ?? "", style: TextStyle(color: Colors.white)),
        ],
      ));
  }
}
