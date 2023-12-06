import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minha_receita/core/config/config.dart';
import 'package:minha_receita/design_system/title/default_title.dart';
import '../../../../../../design_system/appBars/app_bar.dart';
import '../../../../../../design_system/botton_navigation_bars/defalt_botton_navigation_bar.dart';
import '../../../../../../design_system/containers/custom_container.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../../../../../design_system/templates/base_page.dart';
import '../../../../../design_system/errors/error_handle.dart';
import '../../../../../design_system/page_view/page_view.dart';
import '../model/comment_entity.dart';
import '../componentes/feed_card.dart';
import '../model/feed_entity.dart';
import '../model/like_entity.dart';
import '../states/navigator_state.dart';
import '../states/recipe_state.dart';
import '../states/theme_state.dart';

class RecipeMainPage extends StatefulWidget {
  const RecipeMainPage({super.key});

  @override
  State<RecipeMainPage> createState() => _RecipeMainPageState();
}

class _RecipeMainPageState extends State<RecipeMainPage>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  RecipeState recipeStateModel = RecipeState();
  ThemeState themeStateModel = ThemeState();
  PageController pageController = PageController();
  PageNavigatorState pageNavigatorStateModel = PageNavigatorState();

  @override
  void initState() {
    recipeStateModel.getData();
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
      appDSAppBar: AppDSAppBar(
        type: AppDSBarType.variant1,
        actions: _actions(),
      ),
      body: ListenableBuilder(
          listenable: recipeStateModel,
          builder: (context, _) {
            if (recipeStateModel.errorMsg != null) {
              return DSErrorHandle(
                errorMsg: recipeStateModel.errorMsg!,
                tryAgain: recipeStateModel.getData,
              );
            }
            if (recipeStateModel.isLoading) {
              return _onLoadingWidget();
            }

            return DSPageView(
              pageController: pageController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _listOfRecipe(),
                      ...feeds(),
                      // _carousel(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
              ],
            );
          }),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavBar(
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'início',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_outlined,
            ),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
            ),
            label: 'Perfil',
          ),
        ]);
  }

  Widget _onLoadingWidget() {
    return Center(
      child: Lottie.asset(
        'lib/design_system/animations/assets/loading.json',
        height: 200,
        width: 200,
      ),
    );
  }

  Widget _listOfRecipe() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: DSNavigationMenuBar(
            horizontalSpacing: 8,
            items: [
              ...pageNavigatorStateModel.navigationMenuBarList.map(
                (e) => DSNavigationMenuBarItem(
                  subtitle: e['title'],
                  width: 70,
                  customContainer: DSCustomContainer(
                    width: 40,
                    height: 40,
                    iconPadding: const EdgeInsets.all(8),
                    imgURL: 'https://source.unsplash.com/random/80${pageNavigatorStateModel.navigationMenuBarList.indexOf(e)}x600/?person',
                    iconColor: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              )
            ],
            onTap: (int index) {},
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(16),
        //   child: DSNavigationMenuBar(
        //     title: DSDefaultTitle(
        //       title: 'Populares',
        //       leading: Icons.favorite_border,
        //       backgroundColor: Theme.of(context).colorScheme.tertiary,
        //       iconColor: Theme.of(context).colorScheme.primary,
        //     ),
        //     items: [
        //       ...recipeStateModel.recipeList['pop']!
        //           .map((e) => DSNavigationMenuBarItem(
        //                 subtitle: e.title,
        //                 customContainer: DSCustomContainer(
        //                   imgURL: e.imgUrl,
        //                   description: '${e.timeInMinutes} minutos',
        //                   height: 90,
        //                   width: 100,
        //                   shape: const RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(8),
        //                     ),
        //                   ),
        //                 ),
        //               )),
        //     ],
        //     onTap: (int index) {
        //       navigateKey.currentState!.pushNamed('/recipe/ingredients',
        //           arguments: recipeStateModel.recipeList['pop']![index]);
        //     },
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(16),
        //   child: DSNavigationMenuBar(
        //     title: DSDefaultTitle(
        //       title: 'Últimas receitas',
        //       leading: Icons.access_time,
        //       backgroundColor: Theme.of(context).colorScheme.tertiary,
        //       iconColor: Theme.of(context).colorScheme.primary,
        //     ),
        //     items: [
        //       ...recipeStateModel.recipeList['news']!
        //           .map((e) => DSNavigationMenuBarItem(
        //                 subtitle: e.title,
        //                 customContainer: DSCustomContainer(
        //                   imgURL: e.imgUrl,
        //                   height: 150,
        //                   width: 135,
        //                   shape: const RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(8),
        //                     ),
        //                   ),
        //                 ),
        //               )),
        //     ],
        //     onTap: (int index) {
        //       navigateKey.currentState!.pushNamed('/recipe/ingredients',
        //           arguments: recipeStateModel.recipeList['news']![index]);
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget _carousel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DSNavigationMenuBar(
        dsNavigationMenuBarVariants: DSNavigationMenuBarVariants.carousel,
        items: [
          ...recipeStateModel.recipeList['favorites']!
              .map((e) => DSNavigationMenuBarItem(
                    customContainer: DSCustomContainer(
                      description: e.description,
                      descriptionPadding: const EdgeInsets.all(8),
                      imgURL: e.imgUrl,
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.9,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  )),
        ],
        onTap: (int index) {},
      ),
    );
  }

  List<Widget> _actions() {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: themeStateModel.switchTheme,
          child: Center(
            child: ListenableBuilder(
                listenable: themeStateModel,
                builder: (context, _) {
                  return ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.modulate,
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          height: !themeStateModel.isDarkTheme ? 30 : 20,
                          width: !themeStateModel.isDarkTheme ? 25 : 20,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeIn,
                          child: Lottie.asset(
                            'lib/design_system/animations/assets/dark_mode.json',
                            repeat: false,
                            animate: true,
                            controller: themeStateModel.getAnimController(this),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          !themeStateModel.isDarkTheme ? 'Brilho' : 'Escuro',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: !themeStateModel.isDarkTheme
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    ];
  }

  List<Widget> feeds(){
    return [
      FeedCard(
        feedEntity: FeedEntity(
          name: 'Nome',
          description:
          'Aqui vai mais um das minhas receitas, espero que gostem',
          createdAt: '2023-12-01T01:23:45.678+09:00',
          likes: 26,
          userLiked: false,
          comments: [
            CommentEntity(
              comment: 'Comentário',
              id: 1,
              createdAt: '',
              updatedAt: '',
              userId: 1,
              postId: 1,
            ),
          ],
          likesList: [
            LikeEntity(
              description: 'Descrição',
              isFallowing: false,
              name: 'Nome',
              urlImg:
              'https://source.unsplash.com/random/800x600/?person',
            ),
            LikeEntity(
              description: 'Descrição',
              isFallowing: false,
              name: 'Nome',
              urlImg:
              'https://source.unsplash.com/random/700x600/?person',
            ),
          ],
          imgUrl:
          'https://source.unsplash.com/random/750x600/?person',
          recipeImgUrlList: [
            'https://source.unsplash.com/random/780x600/?food',
            'https://source.unsplash.com/random/785x600/?food',
            'https://source.unsplash.com/random/788x600/?food'
          ],
        ),
      ),
      FeedCard(
        feedEntity: FeedEntity(
          name: 'Nome',
          description:
          'Aqui vai mais um das minhas receitas, espero que gostem',
          createdAt: '2023-12-01T01:23:45.678+09:00',
          likes: 26,
          userLiked: false,
          comments: [
            CommentEntity(
              comment: 'Comentário',
              id: 1,
              createdAt: '',
              updatedAt: '',
              userId: 1,
              postId: 1,
            ),
          ],
          likesList: [
            LikeEntity(
              description: 'Descrição',
              isFallowing: false,
              name: 'Nome',
              urlImg:
              'https://source.unsplash.com/random/800x600/?person',
            ),
            LikeEntity(
              description: 'Descrição',
              isFallowing: false,
              name: 'Nome',
              urlImg:
              'https://source.unsplash.com/random/700x600/?person',
            ),
          ],
          imgUrl:
          'https://source.unsplash.com/random/750x600/?person',
          recipeImgUrlList: [
            'https://source.unsplash.com/random/780x600/?food',
            'https://source.unsplash.com/random/785x600/?food',
            'https://source.unsplash.com/random/788x600/?food'
          ],
        ),
      ),
    ];
  }
}
