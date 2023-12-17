import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/core/drivers/camera_access.dart';

import '../../../../design_system/containers/custom_container.dart';
import '../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../domain/model/recipe_model.dart';

class RecipeCarousel extends StatefulWidget {
  const RecipeCarousel({
    super.key,
    required this.model,
   this. editMode = true,
  });

  final bool editMode;
  final RecipeModel model;

  @override
  State<RecipeCarousel> createState() => _RecipeCarouselState();
}

class _RecipeCarouselState extends State<RecipeCarousel> {
  List<String> base64Images = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        base64Images = await GetIt.I.get<CameraAccess>().getMultiImages();
        setState(() {});
      },
      child: Row(
        children: [
          if(widget.editMode)
            Expanded(
              child: SizedBox(
                child: DSNavigationMenuBar(
                  dsNavigationMenuBarVariants: DSNavigationMenuBarVariants.carousel,
                  items: base64Images
                      .map(
                        (e) => DSNavigationMenuBarItem(
                      customContainer: DSCustomContainer(
                        descriptionPadding: const EdgeInsets.all(8),
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.9,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.memory(
                                base64Decode(e),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  )
                      .toList(),
                  onTap: (int index) {},
                ),
              ),
            )
          else
          Expanded(
            child: SizedBox(
              child: DSNavigationMenuBar(
                dsNavigationMenuBarVariants: DSNavigationMenuBarVariants.carousel,
                items: widget.model.recipeImgUrlList
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
      ),
    );
  }
}