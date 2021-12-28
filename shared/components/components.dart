import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.amber,
  bool isUpperCase = true,
  double radius = 5.0,
  required String text,
  required Function function,

}) {
  return Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  required Function? validate,
  required String label,
  required IconData prefix,

})
=> TextFormField(
  controller: controller,
  onFieldSubmitted: onSubmit!(),
  onChanged: onChanged!(),
  validator: validate!(),
  keyboardType: type,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefix
    ),
    labelText: label,
  ),
);
