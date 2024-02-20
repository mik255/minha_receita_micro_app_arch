import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/account/presenter/cubit/email_cubit.dart';
import 'package:minha_receita/modules/account/presenter/cubit/name_cubit.dart';
import 'package:minha_receita/modules/account/presenter/cubit/password_cubit.dart';
import 'package:minha_receita/modules/account/presenter/cubit/register_cubit.dart';
import 'package:minha_receita/modules/account/presenter/pages/login_page.dart';
import 'package:minha_receita/modules/account/presenter/pages/register_page.dart';
import 'presenter/cubit/auth_cubit.dart';

class AccountModule extends Module {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind.singleton<EmailCubit>((i) => EmailCubit(),
            onDispose: (bloc) => bloc.close()),
        Bind.singleton<PasswordCubit>((i) => PasswordCubit(),
            onDispose: (bloc) => bloc.close()),
        Bind.singleton<AuthCubit>((i) => AuthCubit(i.get()),
            onDispose: (bloc) => bloc.close()),
        Bind.singleton<UserNameCubit>((i) => UserNameCubit(),
            onDispose: (bloc) => bloc.close()),
        Bind((i) => RegisterCubit(i.get()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/login/',
          child: (_, args) => const LoginPage(),
          transition: TransitionType.leftToRight,
          duration: const Duration(milliseconds: 500),
        ),
        ChildRoute(
          '/register/',
          child: (_, args) => const RegisterPage(),
          transition: TransitionType.leftToRight,
          duration: const Duration(milliseconds: 500),
        ),
      ];
}
