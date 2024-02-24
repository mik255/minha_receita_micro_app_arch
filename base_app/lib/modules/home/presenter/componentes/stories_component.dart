import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:shimmer/shimmer.dart';

import '../cubit/stories_cubit.dart';

class StoriesComponent extends StatefulWidget {
  const StoriesComponent({Key? key}) : super(key: key);

  @override
  State<StoriesComponent> createState() => _StoriesComponentState();
}

class _StoriesComponentState extends State<StoriesComponent> {
  StoriesCubit storiesCubit = Modular.get();

  @override
  void initState() {
    storiesCubit.getStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                    height: 50,
                                    width: 50,
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
                return const Center(child: Text('Erro ao carregar stories'));
              }

              StoriesLoaded _state = state as StoriesLoaded;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._state.stories.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: () {
                          final isLast = state.stories.last == e;
                          if (isLast) {
                            return 0.0;
                          }
                          return 24.0;
                        }(),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 53,
                                width: 53,
                                decoration: const ShapeDecoration(
                                  shape: OvalBorder(),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF833AB4),
                                      Color(0xFFFD1D1D),
                                      Color(0xFFFCAF45),
                                    ],
                                    stops: [0.1, 0.5, 0.9],
                                  ),
                                ),
                                child: Center(
                                  child: DSCustomContainer(
                                    height: 45,
                                    width: 45,
                                    imgURL: e.userImgUrl,
                                  ),
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
            }),
      ),
    );
  }
}
