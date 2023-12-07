import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../../../../design_system/appBars/app_bar.dart';
import '../../../../../../../design_system/templates/base_page.dart';
import '../../../../../../design_system/containers/custom_container.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../../../../../design_system/title/default_title.dart';
import '../../../../design_system/loadings/default_loading.dart';
import '../states/ingredients_states.dart';
import '../store/recipe_store.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({
    super.key,
  });

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late String recipeId;

  RecipeStore get store => GetIt.I.get<RecipeStore>();

  @override
  void didChangeDependencies() {
    recipeId = ModalRoute.of(context)!.settings.arguments as String;
    store.getRecipeById(recipeId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          var appBar = const AppDSAppBar(
            type: AppDSBarType.variant1,
            title: 'Ingredientes',
            popLeading: true,
          );
          if (store.state is RecipeLoadingState) {
            return AppDSBasePage(
                withScroll: false,
                appDSAppBar: appBar,
                body: const Center(
                  child: DSDefaultLoading(),
                ));
          }
          if (store.state is RecipeException) {
            return const Center(
              child: Text('Erro ao carregar receita'),
            );
          }
          var successState = store.state as RecipeSuccessState;
          var model = successState.recipeModel;
          return AppDSBasePage(
            appDSAppBar: appBar,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: DSNavigationMenuBar(
                          dsNavigationMenuBarVariants:
                              DSNavigationMenuBarVariants.carousel,
                          items: model.recipeImgUrlList
                              .map(
                                (e) => DSNavigationMenuBarItem(
                                  customContainer: DSCustomContainer(
                                    descriptionPadding: const EdgeInsets.all(8),
                                    imgURL: e,
                                    height: 250,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          title: '${model.timeInMinutes} min',
                          leading: Icons.timer,
                        ),
                        DSDefaultTitle(
                          backgroundColor: Colors.transparent,
                          spaceBetween: 0,
                          iconSize: 16,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          title: '${model.timeInMinutes} min',
                          leading: Icons.timer,
                        ),
                        DSDefaultTitle(
                          backgroundColor: Colors.transparent,
                          spaceBetween: 0,
                          iconSize: 16,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
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
                  padding: const EdgeInsets.symmetric(horizontal: 24)
                      .copyWith(top: 16),
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
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '${model.ingredients.indexOf(e) + 1}.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500),
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
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 8.0),
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
                                  iconColor:
                                      Theme.of(context).colorScheme.tertiary,
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
