import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieticket/utils/color.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagepicker = ImagePicker();
  XFile? _file = await _imagepicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No Image selected");
}

showSnackBar(String content, BuildContext context) {// content which is to be is passed in fucntion call
  ScaffoldMessenger.of(context).showSnackBar( //scaffold messenger manages the snackbars, bottomsheets
    SnackBar(content:  Text(
                            content,
                              style:const TextStyle(color: appthemecolor),
                            ),
                            duration:const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: greycolorshade1,),
  );
}