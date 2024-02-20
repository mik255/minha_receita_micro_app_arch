import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/home/presenter/componentes/feed_card.dart';
import 'package:minha_receita/modules/home/presenter/cubit/stories_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/navigator/navigator.dart';
import '../../../../common/theme/presenter/store/theme.dart';
import '../../domain/model/post_entity.dart';
import '../cubit/feed_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final AppThemeStore appTheme = AppThemeStore();
  final pageController = PageController();
  final ScrollController scrollController = ScrollController();
  FeedCubit feedCubit = Modular.get();

  StoriesCubit storiesCubit = Modular.get();

  @override
  void initState() {
    super.initState();
    feedCubit.getFeed();
    storiesCubit.getStories();
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
            text: 'Adicionar receita',
            onTap: () {
              CommonNavigator.navigateKey.currentState!
                  .pushNamed('/recipe/register');
            },
          ),
          DSDrawerMenuItem(
            text: 'Sair',
            onTap: () {
              CommonNavigator.navigateKey.currentState!
                  .pushNamedAndRemoveUntil('/account/login', (route) => false);
            },
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (false) {
          return DSErrorHandle(
              errorMsg: 'Serviço indisponível', tryAgain: () {});
        }
        if (false) {
          return const Center(child: DSDefaultLoading());
        }

        return DSPageView(
          pageController: pageController,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: BlocBuilder(
                        bloc: storiesCubit,
                        builder: (context, state) {
                          if (state is StoriesLoading) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ...List.generate(20, (index) => 0).map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 24),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor: Color(0xFFF0F0F0),
                                              highlightColor: Color(0xFFF7F7F7),
                                              child: const DSCustomContainer(
                                                height: 40,
                                                width: 40,
                                                imgURL:
                                                    'https://source.unsplash.com/random/801x600/?face',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
                            );
                          }
                          if (state is StoriesError) {
                            return const Center(
                                child: Text('Erro ao carregar stories'));
                          }

                          StoriesLoaded _state = state as StoriesLoaded;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ..._state.stories.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          DSCustomContainer(
                                            height: 40,
                                            width: 40,
                                            imgURL:
                                                'https://source.unsplash.com/random/801x600/?face',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })
                            ],
                          );
                        }),
                  ),
                ),
                Expanded(
                  child: BlocBuilder(
                      bloc: feedCubit,
                      builder: (context, state) {
                        if (state is FeedLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state is FeedError) {
                          return const Center(
                              child: Text('Erro ao carregar feed'));
                        }
                        state as FeedLoaded;
                        return ListView.builder(
                            itemCount: state.feed.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FeedCard(
                                    feedEntity: state.feed[index],
                                  )
                                ],
                              );
                            });
                      }),
                ),
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
      //  bottomNavigationBar: _bottomNavigationBarWidget(),
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

  // Widget _topNavigatorMenu(PostStateLoaded state) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: DSNavigationMenuBar(
  //           horizontalSpacing: 8,
  //           items: [
  //             ...state.postList.map(
  //               (e) => DSNavigationMenuBarItem(
  //                // subtitle: e.description,
  //                 width: 70,
  //                 customContainer: DSCustomContainer(
  //                   borderSide: BorderSide(
  //                     width: 2.5,
  //                     style: BorderStyle.solid,
  //                     strokeAlign: 2,
  //                     color: Theme.of(context)
  //                         .colorScheme
  //                         .primary
  //                         .withOpacity(0.8),
  //                   ),
  //                   width: 40,
  //                   height: 40,
  //                   iconPadding: const EdgeInsets.all(8),
  //                   imgURL:
  //                       'https://source.unsplash.com/random/80${state.postList.indexOf(e)}x600/?person',
  //                   iconColor: Theme.of(context).colorScheme.tertiary,
  //                 ),
  //               ),
  //             )
  //           ],
  //           onTap: (int index) {},
  //         ),
  //       ),
  //     ],
  //   );
  // }

  List<Widget> _actions() {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: appTheme.switchTheme,
          child: Center(
            child: AnimatedBuilder(
                animation: appTheme,
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
