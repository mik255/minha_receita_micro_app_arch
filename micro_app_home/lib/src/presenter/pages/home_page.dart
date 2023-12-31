import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import '../componentes/feed_card.dart';
import '../store/home_states.dart';
import '../store/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController controller;
  final AppThemeStore appTheme = AppThemeStore();
  final homeStore = GetIt.I.get<HomeStore>();
  final pageController = PageController();
  final ScrollController scrollController = ScrollController();
 // UserModel get userModel => GetIt.I<UserModel>();
  int page = 1;

  @override
  void initState() {
    homeStore.getListPosts(page);
    scrollController.onBottomListener(() async {
      if (homeStore.postState is PostStateLoading) {
        page++;
        homeStore.getListPosts(page);
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
        avatarImgUrl: "",
        avatarName: 'Usuário',
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
      body: StreamBuilder(
          stream: homeStore.postState,
          builder: (context, _) {
            var state = homeStore.postState.value;
            if (state is PostStateError) {
              return DSErrorHandle(
                  errorMsg: 'Serviço indisponível',
                  tryAgain: () => homeStore.getListPosts(page));
            }
            if (state is PostStateLoading) {
              return const Center(child: DSDefaultLoading());
            }
            state = state as PostStateLoaded;
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
                              itemCount: state.postList.length,
                              itemBuilder: (context, index) {
                                return FeedCard(
                                  feedEntity: (state as PostStateLoaded).postList[index],
                                );
                              },
                            ),
                            // _carousel(),
                          ],
                        ),
                      ),
                    ),
                    if (state is PostStateLazyLoading)
                      LinearProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                      )
                  ],
                ),
                //const RecipePage(),
                Container(
                  color: Colors.blue,
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

  Widget _topNavigatorMenu(PostStateLoaded state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: DSNavigationMenuBar(
            horizontalSpacing: 8,
            items: [
              ...state.postList.map(
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
                        'https://source.unsplash.com/random/80${state.postList.indexOf(e)}x600/?person',
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
                          child: DSGetAnimations().darkMode(
                            appTheme.getAnimController(this),
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
