import 'package:flutter/material.dart';

class Progress{
  static showProgressDialog(BuildContext context, String title) {
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:Text(title)),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
}

  @override
  Widget build(BuildContext context
      ) {
    
    throw UnimplementedError();
  }
}