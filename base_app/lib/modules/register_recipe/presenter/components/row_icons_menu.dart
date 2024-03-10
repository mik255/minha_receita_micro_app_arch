

import 'package:flutter/material.dart';

class RowIconsMenu extends StatelessWidget {
  const RowIconsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
      child: Row(
        children: [
          // Container(
          //   width: 32,
          //   height: 32,
          //   // decoration: const ShapeDecoration(
          //   //   color: Color(0xFFF2F2F2),
          //   //   shape: OvalBorder(),
          //   // ),
          //   child:  Icon(
          //     size: 20,
          //     Icons.photo_camera,
          //     color: Colors.black.withOpacity(0.65),
          //   ),
          // ),
          // const SizedBox(
          //   width: 16,
          // ),
          Container(
            width: 32,
            height: 32,
            decoration: const ShapeDecoration(
              color: Color(0xFFF2F2F2),
              shape: OvalBorder(),
            ),
            child:  Icon(
              size: 20,
              Icons.edit,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ],
      ),
    );
  }
}
