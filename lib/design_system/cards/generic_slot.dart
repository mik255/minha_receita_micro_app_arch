import 'dart:convert';

import 'package:flutter/material.dart';

import 'card_default.dart';

class AppDSGenericSlot extends StatelessWidget {
  const AppDSGenericSlot({
    super.key,
    this.imgUrl,
    required this.title,
    required this.description,
    this.onTap,
  });

  final String? imgUrl;
  final String title;
  final String description;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 150,
        child: AppDSCardDefault(
          child: Row(
            children: [
              if(imgUrl != null)
              SizedBox(
                height: 150,
                width: 150,
                child: Image.memory(
                  base64Decode(imgUrl!.split(',').last),
                  fit: BoxFit.cover,
                ),
              )
              else
              const SizedBox(
                height: 150,
                width: 150,
                child: Icon(Icons.add_a_photo_outlined),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
