import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      // width: double.infinity,
      child: Card(
        elevation: 2,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          child: Text('Chart will go here!'),
        ),
      ),
    );
  }
}
