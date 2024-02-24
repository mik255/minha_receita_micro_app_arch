import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/account/presenter/cubit/auth_cubit.dart';
import 'package:minha_receita/modules/account/presenter/cubit/email_cubit.dart';
import 'package:minha_receita/modules/account/presenter/states/auth_states.dart';
import '../../../../common/models/credentials.dart';
import '../../../../common/navigator/navigator.dart';
import '../cubit/password_cubit.dart';
import '../states/email_states.dart';
import '../states/password_states.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    EmailCubit emailCubit = Modular.get();
    PasswordCubit passwordCubit = Modular.get();
    AccountCubit authCubit = Modular.get();
    //turn up


    return BlocListener(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            Modular.to.pushNamedAndRemoveUntil(
              '/home',
              (route) => false,
            );
          }
        },
        bloc: authCubit,
        child: AppDSBasePage(
          withScroll: true,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: DSLogo().get(),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: DSDefaultCardDialogContent(
                  title: 'Login',
                  subtitle:
                      'Bem vindo ao minha receita, estamos feliz por ter você aqui,',
                  middleCustomContent: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        BlocBuilder<EmailCubit, EmailState>(
                            bloc: emailCubit,
                            builder: (context, state) {
                              return AppDSTextField(
                                controller: emailController,
                                errorMsg: () {
                                  if (state is EmailInvalid) {
                                    return state.message;
                                  }
                                  return null;
                                }(),
                                hintText: 'Email',
                                onChange: emailCubit.setEmail,
                              );
                            }),
                        BlocBuilder(
                            bloc: passwordCubit,
                            builder: (context, state) {
                              return AppDSTextField(
                                obscureText: true,
                                controller: passwordController,
                                errorMsg: () {
                                  if (state is PasswordInvalid) {
                                    return state.message;
                                  }
                                  return null;
                                }(),
                                hintText: 'Senha',
                                onChange: (value) {
                                  passwordCubit.setPassword(value);
                                },
                              );
                            }),
                        DSCheckBox(
                          description: 'Lembrar',
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  buttons: [
                    Column(
                      children: [
                        DSTextButton(
                          onPressed: () {
                            Modular.to.pushNamed('/account/register/');
                          },
                          text: 'Cadastre-se',
                        ),
                        Row(
                          children: [
                            StreamBuilder(
                                stream: StreamGroup.merge([
                                  emailCubit.stream,
                                  passwordCubit.stream,
                                  authCubit.stream,
                                ]),
                                builder: (context, snapshot) {
                                  return Expanded(
                                    child: DSCustomButton(
                                        padding: EdgeInsets.zero,
                                        text: 'Entrar',
                                        isLoading: authCubit.state
                                            is AuthLoadingState,
                                        enabled: () {
                                          if (authCubit.state
                                              is AuthLoadingState) {
                                            return false;
                                          }
                                          if (emailCubit.state
                                              is! EmailValid) {
                                            return false;
                                          }
                                          if (passwordCubit.state
                                              is! PasswordValid) {
                                            return false;
                                          }
                                          return true;
                                        }(),
                                        onTap: () async {
                                          authCubit.auth(
                                            Credentials(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text,
                                            ),
                                          );
                                        }),
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
