import 'package:flutter/material.dart';
import 'package:leadsgo_apps/components/text_field_container.dart';
import 'package:leadsgo_apps/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: leadsGoColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: leadsGoColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: leadsGoColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
