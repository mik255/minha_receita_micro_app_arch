import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/home/data/repository/home_repository.dart';
import 'package:minha_receita/modules/home/domain/model/stories_entity.dart';
import 'package:minha_receita/modules/home/presenter/cubit/feed_cubit.dart';
import 'package:minha_receita/modules/home/presenter/cubit/stories_cubit.dart';
import 'package:minha_receita/modules/home/presenter/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<FeedCubit>(
            (i) => FeedCubit(
                  HomeRepositoryImpl(
                    i.get(),
                  ),
                ),
            onDispose: (bloc) => bloc.close()),
        Bind.singleton<StoriesCubit>(
            (i) => StoriesCubit(
                  HomeRepositoryImpl(
                    i.get(),
                  ),
                ),
            onDispose: (bloc) => bloc.close()),
      ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const HomePage(),
    ),
  ];
}
