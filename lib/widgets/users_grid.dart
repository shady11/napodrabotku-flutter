import 'package:flutter/material.dart';

class UsersGrid extends StatelessWidget {

  // Variables
  final List<Widget> children;

  UsersGrid({@required this.children});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 250 / 320,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      children: children
  );
 } 
}