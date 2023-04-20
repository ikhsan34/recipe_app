import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loadings {

  static Widget fadingCircle() {
    return SpinKitFadingCircle(
      color: Colors.grey[350],
      size: 100,
    );
  }

}

