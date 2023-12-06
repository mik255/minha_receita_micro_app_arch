import 'package:flutter/material.dart';

import '../../../../../../../design_system/appBars/app_bar.dart';
import '../../../../../../../design_system/cards/card_with_image.dart';
import '../../../../../../../design_system/templates/base_page.dart';
import '../../../../../../design_system/containers/custom_container.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../../../../../design_system/title/default_title.dart';
import '../../../main/model/recipe_model.dart';

class IgredientsPage extends StatefulWidget {
  const IgredientsPage({
    super.key,
  });

  @override
  State<IgredientsPage> createState() => _IgredientsPageState();
}

class _IgredientsPageState extends State<IgredientsPage> {
  late RecipeModel model;

  @override
  void didChangeDependencies() {
    model = ModalRoute.of(context)!.settings.arguments as RecipeModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
      appDSAppBar: const AppDSAppBar(
        type: AppDSBarType.variant1,
        title: 'Ingredientes',
        popLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: DSNavigationMenuBar(
                      dsNavigationMenuBarVariants:
                          DSNavigationMenuBarVariants.carousel,
                      items: [
                        ...[model.imgUrl, model.imgUrl, model.imgUrl].map(
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
                      ],
                      onTap: (int index) {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DSCustomContainer(
              backgroundColor: Colors.transparent,
              descriptionPadding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.9,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DSDefaultTitle(
                      backgroundColor: Colors.transparent,
                      spaceBetween: 0,
                      iconSize: 16,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                      title: '${model.timeInMinutes} min',
                      leading: Icons.timer,
                    ),
                    DSDefaultTitle(
                      backgroundColor: Colors.transparent,
                      spaceBetween: 0,
                      iconSize: 16,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                      title: '${model.timeInMinutes} min',
                      leading: Icons.timer,
                    ),
                    DSDefaultTitle(
                      backgroundColor: Colors.transparent,
                      spaceBetween: 0,
                      iconSize: 16,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                      title: '${model.timeInMinutes} min',
                      leading: Icons.timer,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 16),
              child: DSDefaultTitle(
                backgroundColor: Colors.transparent,
                spaceBetween: 0,
                iconSize: 16,
                title: model.title,
                description: Text(
                  model.description ?? 'null',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DSDefaultTitle(
                        title: 'Ingredientes',
                        leading: Icons.shopping_bag,
                        iconColor: Theme.of(context).colorScheme.tertiary),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ...model.ingredients
                      .map((e) => Padding(
                    padding: const EdgeInsets.only(left:4,bottom: 8.0),
                        child: Row(
                              children: [
                                Text(
                                  '${model.ingredients.indexOf(e) + 1}.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(child: Text('${e.description}.')),
                              ],
                            ),
                      ))
                      .toList(),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DSDefaultTitle(
                        title: 'Modo de Preparo',
                        leading: Icons.access_time,
                        iconColor: Theme.of(context).colorScheme.tertiary),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ...model.steps
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(left:4,bottom: 8.0),
                            child: DSDefaultTitle(
                              title: e.description,
                              leadingBorderRadius: 24,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                              leadingText: () {
                                var index = model.steps.indexOf(e) + 1;
                                return index.toString();
                              }(),
                              iconColor: Theme.of(context).colorScheme.tertiary,
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
