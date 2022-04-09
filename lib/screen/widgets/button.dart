import 'package:flutter/cupertino.dart';
import 'package:flutter_project/my_theme.dart';
class Button extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const Button({ Key? key, required this.label,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:100,
        height:50,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(20),
          color:MyTheme.call_icon
        ),
        child: Text(
          label,
          style: TextStyle(
              color: MyTheme.accent_color
          ),

        ),
      ),

      
    );
  }
}