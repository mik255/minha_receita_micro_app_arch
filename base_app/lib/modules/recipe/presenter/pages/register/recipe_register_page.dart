import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/recipe/presenter/pages/register/views/add_photo_or_video.dart';
import 'package:minha_receita/modules/recipe/presenter/pages/register/views/description_view.dart';

import 'components/header.dart';

abstract class PageData extends Widget {
  const PageData({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.buttons,
  });

  final String title;
  final String description;
  final IconData icon;
  final Widget buttons;
}

class RegisterRecipePage extends StatefulWidget {
  const RegisterRecipePage({super.key});

  @override
  State<RegisterRecipePage> createState() => _RegisterRecipePageState();
}

class _RegisterRecipePageState extends State<RegisterRecipePage> {
  List<PageData> pagesData = [
    const DescriptionView(),
    const AddPhotoOrVideo(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
        body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                RegisterHeader(
                  data: pagesData[0],
                ),
               pagesData[0]
              ],
            )),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            pagesData[0].buttons,
          ],
        ));
  }
}
