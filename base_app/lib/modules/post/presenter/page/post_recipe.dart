import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/post/presenter/states/post_states.dart';
import 'package:minha_receita/modules/register_recipe/models/recipe_model.dart';
import '../../../../common/navigator/navigator.dart';
import '../store/post_store.dart';


class PostRecipePage extends StatefulWidget {
  const PostRecipePage({super.key});
  @override
  State<PostRecipePage> createState() => _PostRecipePageState();
}

class _PostRecipePageState extends State<PostRecipePage> {
  var pageController = PageController();
  PostStore store = GetIt.I<PostStore>();
  bool initialState = true;
  RecipeModel? recipe;
  @override
  void didChangeDependencies() {
    if(initialState){
      var recipeData = ModalRoute.of(context)!.settings.arguments as RecipeModel;
      recipe = recipeData;
      if (kDebugMode) {
        print("recipe id ${recipe!.id}");
      }
      initialState = false;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
      appDSAppBar: const AppDSAppBar(
        type: AppDSBarType.variant1,
        backgroundColor: Colors.transparent,
        onlyLeading: true,
        title: 'Postar Receita',
        popLeading: true,
      ),
      body: AnimatedBuilder(
          animation: store,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DSAvatar(
                  size: 100,
                  imgUrl:
                      'https://source.unsplash.com/random/80x600/?wallpaper',
                  nameStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  nameBelowAvatar: true,
                  namePadding: EdgeInsets.symmetric(vertical: 16),
                  name: 'mikael',
                ),
                Expanded(
                  child: DSPageView(pageController: pageController, children: [
                    _form(store.state),
                    _successVerification(),
                  ]),
                )
              ],
            );
          }),
    );
  }

  Widget _form(PostStates state) {
    return Padding(
      padding: const EdgeInsets.all(32.0).copyWith(top: 0),
      child: DSDefaultCardDialogContent(
        title: 'Descrição do post',
        subtitle:
            'Adicione uma breve texto sobre a sua receita que irá ser mostrado na descrição do post',
        middleCustomContent: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              AppDSTextField(
                controller: store.descriptionTextController,
                maxLines: 5,
                onValidate: (value) {
                  return null;
                },
                hintText: 'descrição',
              ),
            ],
          ),
        ),
        buttons: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: DSCustomButton(
                        padding: EdgeInsets.zero,
                        text: 'Continuar',
                        isLoading: state is PostLoadingState,
                        onTap: () async{
                          bool success = await store.postRecipe(recipe!.id);
                          if(success){
                            pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _successVerification() {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0).copyWith(top: 0),
            child: DSDefaultCardDialogContent(
              title: 'Sucesso',
              middleCustomContent: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DSDefaultTitle(
                      title: 'Sucesso',
                      description: Text('Sua receita foi postada com sucesso!'),
                    )
                  ],
                ),
              ),
              buttons: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DSCustomButton(
                              padding: EdgeInsets.zero,
                              text: 'Continuar',
                              isLoading: false,
                              onTap: () {
                              CommonNavigator.navigateTo('/home/main');
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
