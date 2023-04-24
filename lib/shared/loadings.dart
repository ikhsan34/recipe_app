import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loadings {

  static Widget fadingCircle() {
    return SpinKitFadingCircle(
      color: Colors.grey[350],
      size: 100,
    );
  }

  static Widget simpleCircleLoading(BuildContext context) {
    return SpinKitCircle(
      color: Theme.of(context).colorScheme.primary,
    );
  } 

}

