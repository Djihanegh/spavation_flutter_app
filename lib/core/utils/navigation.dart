import 'package:flutter/material.dart';

navigateToPage<T>(Widget page, BuildContext context) async {
  Navigator.of(context).push(createRoute(page));
}

pushReplacement<T>(Widget page, BuildContext context) async {
  Navigator.of(context).pushReplacement(createRoute(page));
}

navigateAndRemoveUntil<T>(Widget page, BuildContext context, bool type) async {
  Navigator.of(context).pushAndRemoveUntil(createRoute(page), (route) => type);
}

pushAndRemoveUntil<T>(Widget page, BuildContext context) {
  Navigator.of(context, rootNavigator: true)
      .pushAndRemoveUntil(createRoute(page), (route) => false);
}

popWithRoot<T>(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

pop(BuildContext context) {
  Navigator.pop(context);
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.5);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
