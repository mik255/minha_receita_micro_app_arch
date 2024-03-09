import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.photo_camera_outlined,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            'Adicionar foto',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
