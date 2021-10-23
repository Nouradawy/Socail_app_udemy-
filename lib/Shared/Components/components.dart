import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function() function,
  required String text,
  bool isUpperCase = true,
  double radius = 3.0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
    );

Widget defaultTextForm(
  context, {
  required TextEditingController controller,
  required TextInputType keyBoardType,
  required String text,
  required Function() onTap,
  Function(String?)? onChang,
  bool IsPassword = false,
  // bool ObsText = false
  String? Function(String?)? validate,
  IconData? preIcon,
  IconData? SuffixIcon,
  bool AutoFocus = false,
  String? prefixText,
  var Cubit,
}) {
  final bool isactive = IsPassword;
  isactive ? IsPassword = Cubit.isPassword : null;

  return TextFormField(
    controller: controller,
    autofocus: AutoFocus,
    obscureText: IsPassword,
    keyboardType: keyBoardType,
    validator: validate,
    onTap: onTap,
    onChanged: onChang,
    decoration: InputDecoration(
      prefixText: prefixText,
      labelText: text,
      prefixIcon: Icon(
        preIcon,
      ),
      suffixIcon: isactive
          ? IconButton(
              onPressed: () {
                Cubit.Passon();
              },
              icon: Icon(Cubit.suffixIcon),
            )
          : IconButton(
              onPressed: () {},
              icon: Icon(SuffixIcon),
            ),
      border: OutlineInputBorder(),
    ),
  );


}

void showToast({
  required String text,
  required ToastStates state,})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
