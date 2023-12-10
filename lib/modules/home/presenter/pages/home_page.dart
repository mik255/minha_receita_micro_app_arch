import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:minha_receita/design_system/menu/drawer/drawer.dart';
import 'package:minha_receita/design_system/menu/drawer/drawer_item.dart';
import 'package:minha_receita/modules/recipe/presenter/pages/recipe_page.dart';
import '../../../../../../design_system/appBars/app_bar.dart';
import '../../../../../../design_system/botton_navigation_bars/defalt_botton_navigation_bar.dart';
import '../../../../../../design_system/containers/custom_container.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../../../../../design_system/templates/base_page.dart';
import '../../../../../design_system/errors/error_handle.dart';
import '../../../../../design_system/page_view/page_view.dart';
import '../../../../design_system/loadings/default_loading.dart';
import '../../../common/theme/presenter/store/theme.dart';
import '../componentes/feed_card.dart';
import '../store/feed_store/feed_store.dart';
import '../store/feed_store/states/feed_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  final AppThemeStore appTheme = AppThemeStore();
  final feedStore = GetIt.I.get<FeedStore>();
  final pageController = PageController();

  @override
  void initState() {
    feedStore.getListFeed();
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
      withScroll: false,
      appDSAppBar: AppDSAppBar(
        type: AppDSBarType.variant1,
        actions: _actions(),
      ),
      drawer: const DSDrawerMenu(
        avatarImgUrl: 'https://source.unsplash.com/random/801x600/?person',
        avatarName: 'João',
        items: [
          DSDrawerMenuItem(text: 'Adicionar ou alterar foto'),
          DSDrawerMenuItem(text: 'Minhas receitas'),
          DSDrawerMenuItem(text: 'Alterar nome'),
          DSDrawerMenuItem(text: 'Sair'),
        ],
      ),
      body: ListenableBuilder(
          listenable: feedStore,
          builder: (context, _) {
            if (feedStore.state is FeedFailureState) {
              return DSErrorHandle(
                  errorMsg: 'Serviço indisponível',
                  tryAgain: () => feedStore.getListFeed());
            }
            if (feedStore.state is FeedLoadingState) {
              return const Center(child: DSDefaultLoading());
            }
            var state = feedStore.state as FeedSuccessState;
            return DSPageView(
              pageController: pageController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _topNavigatorMenu(state),
                      ...feeds(state),
                      // _carousel(),
                    ],
                  ),
                ),
                const RecipePage(),
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

  Widget _topNavigatorMenu(FeedSuccessState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: DSNavigationMenuBar(
            horizontalSpacing: 8,
            items: [
              ...state.feedEntityList.map(
                (e) => DSNavigationMenuBarItem(
                  subtitle: e.description,
                  width: 70,
                  customContainer: DSCustomContainer(
                    width: 40,
                    height: 40,
                    iconPadding: const EdgeInsets.all(8),
                    imgURL:
                        'https://source.unsplash.com/random/80${state.feedEntityList.indexOf(e)}x600/?person',
                    iconColor: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              )
            ],
            onTap: (int index) {},
          ),
        ),
      ],
    );
  }

  List<Widget> _actions() {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: appTheme.switchTheme,
          child: Center(
            child: ListenableBuilder(
                listenable: appTheme,
                builder: (context, _) {
                  return ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.modulate,
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          height: !appTheme.isDarkTheme ? 30 : 20,
                          width: !appTheme.isDarkTheme ? 25 : 20,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeIn,
                          child: Lottie.asset(
                            'lib/design_system/animations/assets/dark_mode.json',
                            repeat: false,
                            animate: true,
                            controller: appTheme.getAnimController(this),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          !appTheme.isDarkTheme ? 'Brilho' : 'Escuro',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: !appTheme.isDarkTheme
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

  List<Widget> feeds(FeedSuccessState state) {
    return state.feedEntityList
        .map((e) => FeedCard(
              feedEntity: e,
            ))
        .toList();
  }
}
