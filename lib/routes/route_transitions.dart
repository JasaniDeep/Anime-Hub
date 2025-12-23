import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteTransitions {
  static GetPageRoute fadeTransition(Widget page) {
    return GetPageRoute(
      page: () => page,
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static GetPageRoute slideTransition(Widget page, {Transition transition = Transition.rightToLeft}) {
    return GetPageRoute(
      page: () => page,
      transition: transition,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  static GetPageRoute scaleTransition(Widget page) {
    return GetPageRoute(
      page: () => page,
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  static GetPageRoute zoomTransition(Widget page) {
    return GetPageRoute(
      page: () => page,
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  static GetPageRoute customSlideTransition(Widget page) {
    return GetPageRoute(
      page: () => page,
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }
}

