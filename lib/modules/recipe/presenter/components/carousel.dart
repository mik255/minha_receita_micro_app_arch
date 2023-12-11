import 'package:flutter/material.dart';

import '../../../../design_system/containers/custom_container.dart';
import '../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../domain/model/recipe_model.dart';

class RecipeCarousel extends StatelessWidget {
  const RecipeCarousel({
    super.key,
    required this.model,
  });

  final RecipeModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: DSNavigationMenuBar(
              dsNavigationMenuBarVariants: DSNavigationMenuBarVariants.carousel,
              items: model.recipeImgUrlList
                  .map(
                    (e) => DSNavigationMenuBarItem(
                  customContainer: DSCustomContainer(
                    descriptionPadding: const EdgeInsets.all(8),
                    imgURL: e,
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.9,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
              onTap: (int index) {},
            ),
          ),
        ),
      ],
    );
  }
}