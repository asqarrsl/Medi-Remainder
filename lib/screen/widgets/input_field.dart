import 'package:flutter/material.dart';
import 'package:medi_remainder/my_theme.dart';


class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const InputField({ Key? key,
  required this.title,
  required this.hint,
  this.controller,
  this.widget }) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      margin: EdgeInsets.only(top:16),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:titleStyle,
          ),
          Container(
            height: 52,

            margin: EdgeInsets.only(top:8.0),
            decoration: BoxDecoration(
              border:Border.all(
                color: MyTheme.dark_grey,
                width:1.0
              ),
            borderRadius: BorderRadius.circular(12)
            ),
            child:Row(
              children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: widget==null?false:true,
                      autofocus: false,
                      cursorColor: MyTheme.font_grey,
                      controller: controller,
                      style: subtitleStyle,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subtitleStyle,
                        focusedBorder: UnderlineInputBorder(
                             borderSide: BorderSide(
                             color:MyTheme.white,
                             width: 0
                           )
                         ),
                         enabledBorder: UnderlineInputBorder(
                             borderSide: BorderSide(
                             color:MyTheme.white,
                             width: 0
                         )
                         ),
                       ),
                    ) ,
                    ),
                    widget==null?Container():Container(child:widget)  
            ],
            ),
          )
        ],
      )
      
    );
  }
}