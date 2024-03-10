import 'package:flutter/material.dart';
import 'package:movieticket/utils/color.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;// to chheck whether passed text is of password or not for obsecure text
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({Key? key,required this.textEditingController, this.isPass=false, required this.hintText,required this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return TextField(
      cursorColor: appthemecolor,
      controller:textEditingController ,
      decoration:InputDecoration(
        fillColor: greycolorshade1,
        hintText:hintText ,
       // hintStyle: TextStyle(color: appthemecolor.withOpacity(0.22)),
        border: OutlineInputBorder(
         
          borderSide: Divider.createBorderSide(context),
        ),
        focusedBorder:const OutlineInputBorder(
          
           borderSide:  BorderSide(color: appthemecolor,),
          ),
          
        
        enabledBorder:const OutlineInputBorder(
          
        
          
        ), 
        hintStyle: TextStyle(fontSize: 20),
        filled: true,
        contentPadding:const EdgeInsets.all(20),
      ) ,
      keyboardType: textInputType,
      obscureText:isPass ,
    );
  }
}
