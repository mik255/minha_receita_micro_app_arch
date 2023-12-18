import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:minha_receita/design_system/menu/drawer/drawer.dart';
import 'package:minha_receita/design_system/menu/drawer/drawer_item.dart';
import 'package:minha_receita/modules/common/extensions/scroll_controller.dart';
import 'package:minha_receita/modules/recipe/presenter/pages/recipe_page.dart';
import 'package:video_player/video_player.dart';
import '../../../../../../design_system/appBars/app_bar.dart';
import '../../../../../../design_system/botton_navigation_bars/defalt_botton_navigation_bar.dart';
import '../../../../../../design_system/containers/custom_container.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../../../../../design_system/templates/base_page.dart';
import '../../../../../design_system/errors/error_handle.dart';
import '../../../../../design_system/page_view/page_view.dart';
import '../../../../design_system/loadings/default_loading.dart';
import '../../../../modules_injections.dart';
import '../../../common/theme/presenter/store/theme.dart';
import '../../../common/user/domain/models/user.dart';
import '../componentes/feed_card.dart';
import '../store/feed_store/feed_store.dart';
import '../store/feed_store/states/feed_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController controller;
  final AppThemeStore appTheme = AppThemeStore();
  final feedStore = GetIt.I.get<FeedStore>();
  final pageController = PageController();
  final ScrollController scrollController = ScrollController();

  UserModel get userModel => GetIt.I<UserModel>();
  int page = 1;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  bool initial = true;
  @override
  void initState() {
    feedStore.getListFeed(page);
    scrollController.onBottomListener(() async {
      if (!isLoading.value) {
          isLoading.value = true;
          page++;
          await feedStore.getMore(page);
          isLoading.value = false;
      }
    });
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
      drawer: DSDrawerMenu(
        avatarImgUrl: "${AppInjections.baseUrl}/${userModel.avatarImgUrl}",
        avatarName: userModel.name ?? 'Usuário',
        items: [
          const DSDrawerMenuItem(text: 'Adicionar ou alterar foto'),
          const DSDrawerMenuItem(text: 'Minhas receitas'),
          const DSDrawerMenuItem(text: 'Alterar nome'),
          DSDrawerMenuItem(
            text: 'Sair',
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/account/login', (route) => false);
            },
          ),
        ],
      ),
      body: ListenableBuilder(
          listenable: feedStore,
          builder: (context, _) {
            if (feedStore.state is FeedFailureState) {
              return DSErrorHandle(
                  errorMsg: 'Serviço indisponível',
                  tryAgain: () => feedStore.getListFeed(page));
            }
            if (feedStore.state is FeedLoadingState) {
              return const Center(child: DSDefaultLoading());
            }
            initial = false;
            var state = feedStore.state as FeedSuccessState;
            return DSPageView(
              pageController: pageController,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            _topNavigatorMenu(state),
                           ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.feedEntityList.length,
                              itemBuilder: (context, index) {
                                return FeedCard(
                                  feedEntity: state.feedEntityList[index],
                                );
                              },
                            ),
                            // _carousel(),
                          ],
                        ),
                      ),
                    ),
                    ListenableBuilder(
                        listenable: isLoading,
                        builder: (ctx, _) {
                          return LinearProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            value: isLoading.value ? null : 0,
                          );
                        })
                  ],
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
                    borderSide: BorderSide(
                      width: 2.5,
                      style: BorderStyle.solid,
                      strokeAlign: 2,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.8),
                    ),
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

}
