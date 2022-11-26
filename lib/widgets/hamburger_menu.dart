import 'package:flutter/material.dart';

Widget HamburgerMenu(var scaffoldKey) {
  return Positioned(
    left: 20,
    top: 60,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1.5),
            ),
          ]),
      child: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
      ),
      //   ),
    ),
  );
}
