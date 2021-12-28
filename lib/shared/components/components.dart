import 'package:flutter/material.dart';
import 'package:flutter_app_1/shared/cubit/cubit.dart';
//
// Widget defaultButton({
//   double width = double.infinity,
//   Color background = Colors.amber,
//   bool isUpperCase = true,
//   double radius = 5.0,
//   required String text,
//   required Function function,
//
// }) => Container(
//       width: width,
//       height: 40.0,
//       child: MaterialButton(
//         onPressed: function(),
//         child: Text(
//           isUpperCase ? text.toUpperCase() : text,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(radius),
//         color: background,
//       ),
//     );
//
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  // required String? Function(String? value) validator,

})
=> TextFormField(
  controller: controller,
  onFieldSubmitted: (String value){
    onSubmit!(value);
  },
  onChanged: (b){
    onChanged!(b);
  },
  validator: (value){
    validate(value);
  },
  onTap: (){
    onTap!();
  },
  keyboardType: type,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefix,
    ),
    suffixIcon: suffix != null
        ? IconButton(
        onPressed: suffixPressed!(),
        icon: Icon(suffix))
        : null,
    labelText: label,
  ),
);

Widget buildTaskItem(Map model, context) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row
    (
    children:
    [
      CircleAvatar(
        radius: 35.0,
        child: Text(
          '${model['time']}',
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            Text(
              '${model['title']}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${model['date']}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      IconButton(
          onPressed: ()
          {
            AppCubit.get(context).UpdateData(
              status: 'done',
              id: model['id'],
            );

          },
          icon: Icon(Icons.check_box),
        color: Colors.green,
      ),
      IconButton(
        onPressed: ()
        {

        },
        icon: Icon(Icons.archive),
        color: Colors.black45,
      ),
    ],
  ),
);