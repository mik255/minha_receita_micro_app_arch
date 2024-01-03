import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:micro_app_core/micro_app_core.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import '../components/about.dart';
import '../components/carousel.dart';
import '../components/ingredients.dart';
import '../components/recipe_status.dart';
import '../components/steps.dart';
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
  late String? recipeId;
  bool initialized = false;

  ThemeData get theme => Theme.of(context);

  RecipeStore get store => GetIt.I.get<RecipeStore>();

  @override
  void didChangeDependencies() {
    if (!initialized) {
      recipeId = ModalRoute.of(context)!.settings.arguments as String?;
      store.getRecipe(recipeId);
      initialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          if (store.state is RecipeLoadingState) {
            return AppDSBasePage(
                withScroll: false,
                appDSAppBar: _appBar('Carregando...'),
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
          var space = const SizedBox(
            height: 16,
          );
          return AppDSBasePage(
              withScroll: false,
              //appDSAppBar: _appBar(model.title),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async{
                            var files = await GetIt.I
                                .get<DeviceDataAccess>()
                                .pickVideos();
                            store.addFiles(files);
                          },
                          child: RecipeCarousel(model: model)),
                      space,
                      RecipeStatusPanel(
                          context: context, theme: theme, model: model),
                      About(theme: theme, store: store, model: model),
                      Ingredients(store: store, theme: theme),
                      _addItemButton(() {
                        store.addIngredient();
                      }),
                      space,
                      Steps(store: store, theme: theme),
                      _addItemButton(() => store.addStep())
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: DSCustomButton(
                text: 'Nova Receita',
                onTap: () {
                  String? hasError = store.buttonIsEnable();
                  if(hasError == null) {
                    store.postRecipe();
                   // Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(hasError),
                      ),
                    );
                  }
                },
              ));
        });
  }

  Widget _addItemButton(Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // DSCustomContainer(
            //   height: 24,
            //   width: 24,
            //   backgroundColor: theme.colorScheme.primary,
            //   shadows: true,
            //   iconData: Icons.add,
            //   iconColor: theme.colorScheme.tertiary,
            // ),
            // const SizedBox(
            //   width: 8,
            // ),
            Text(
              'Adicionar item',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  AppDSAppBar _appBar(String title) => AppDSAppBar(
        type: AppDSBarType.variant1,
        title: title,
        popLeading: true,
      );
}
