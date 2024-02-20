import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/account/presenter/cubit/code_confirmation_cubit.dart';
import 'package:minha_receita/modules/account/presenter/cubit/name_cubit.dart';
import 'package:minha_receita/modules/account/presenter/cubit/register_cubit.dart';
import 'package:minha_receita/modules/account/presenter/states/code_confirmation_states.dart';
import 'package:minha_receita/modules/account/presenter/states/password_states.dart';
import 'package:minha_receita/modules/account/presenter/states/user_name_states.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/dto/register_dto.dart';
import '../cubit/email_cubit.dart';
import '../cubit/password_cubit.dart';
import '../states/email_states.dart';
import '../states/register_states.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var codeController = TextEditingController();
  var pageController = PageController();

  late EmailCubit emailCubit;
  late PasswordCubit passwordCubit;
  late PasswordCubit passwordConfirmationCubit;

  late RegisterCubit registerCubit;

  late UserNameCubit nameCubit;

  late CodeConfirmationCubit codeConfirmationCubit;

  BehaviorSubject<bool> acceptTerms = BehaviorSubject<bool>.seeded(false);

  @override
  void initState() {
    registerCubit = Modular.get();
    codeConfirmationCubit = CodeConfirmationCubit(Modular.get());
    emailCubit = Modular.get();
    passwordCubit = Modular.get();
    nameCubit = Modular.get();
    nameController.text = nameCubit.userName;
    emailController.text = emailCubit.email;
    passwordController.text = passwordCubit.password;
    passwordConfirmationCubit = PasswordCubit();
    codeConfirmationCubit.stream.listen((event) {
      if (event is CodeConfirmationSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const DSSnackBar(
            message: 'Código confirmado com sucesso!',
          ).build,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
      appDSAppBar: const AppDSAppBar(
        type: AppDSBarType.variant1,
        backgroundColor: Colors.transparent,
        onlyLeading: true,
        title: 'Cadastro',
        popLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const DSAvatar(
            size: 100,
            imgUrl: 'https://source.unsplash.com/random/80x600/?wallpaper',
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
              _form(),
              _codeVerification(),
            ]),
          )
        ],
      ),
    );
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.all(32.0).copyWith(top: 0),
      child: DSDefaultCardDialogContent(
        title: 'Cadastro',
        subtitle:
            'Bem vindo ao minha receita, estamos feliz por ter você aqui, cadastre-se para continuar',
        middleCustomContent: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              BlocBuilder(
                  bloc: nameCubit,
                  builder: (context, state) {
                    return AppDSTextField(
                      controller: nameController,
                      errorMsg: () {
                        if (state is UserNameNotValid) {
                          return state.message;
                        }
                      }(),
                      hintText: 'como podemos te chamar?',
                      onChange: nameCubit.setName,
                    );
                  }),
              BlocBuilder(
                  bloc: emailCubit,
                  builder: (context, state) {
                    return AppDSTextField(
                      controller: emailController,
                      errorMsg: () {
                        if (state is EmailInvalid) {
                          return state.message;
                        }
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
                      }(),
                      hintText: 'Senha',
                      onChange: passwordCubit.setPassword,
                    );
                  }),
              BlocBuilder(
                  bloc: passwordConfirmationCubit,
                  builder: (context, state) {
                    return AppDSTextField(
                      obscureText: true,
                      controller: confirmPasswordController,
                      errorMsg: () {
                        if (state is PasswordInvalid) {
                          return state.message;
                        }
                        if (passwordCubit.password !=
                            passwordConfirmationCubit.password) {
                          return 'As senhas não conferem';
                        }
                      }(),
                      hintText: 'Confirme sua senha',
                      onChange: passwordConfirmationCubit.setPassword,
                    );
                  }),
            ],
          ),
        ),
        buttons: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSCheckBox(
                description: 'Aceitar os termos de uso',
                onChanged: (value) {
                  acceptTerms.add(value);
                },
              ),
              DSTextButton(
                onPressed: () {
                  // CommonNavigator.navigateTo(
                  //   '/account/register',
                  // );
                },
                text: 'ler termos de uso',
              ),
              Row(
                children: [
                  StreamBuilder(
                      stream: StreamGroup.merge([
                        emailCubit.stream,
                        passwordCubit.stream,
                        passwordConfirmationCubit.stream,
                        nameCubit.stream,
                        registerCubit.stream,
                        acceptTerms.stream
                      ]),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: DSCustomButton(
                              padding: EdgeInsets.zero,
                              text: 'Continuar',
                              isLoading: registerCubit.state is RegisterLoading,
                              enabled: () {
                                if (nameCubit.state is UserNameNotValid) {
                                  return false;
                                }
                                if (registerCubit.state is RegisterLoading) {
                                  return false;
                                }
                                if (emailCubit.state is! EmailValid) {
                                  return false;
                                }
                                if (passwordCubit.state is! PasswordValid) {
                                  return false;
                                }
                                if (passwordCubit.password !=
                                    passwordConfirmationCubit.password) {
                                  return false;
                                }
                                if (!acceptTerms.value) {
                                  return false;
                                }
                                return true;
                              }(),
                              onTap: () async {
                                await registerCubit.requestRegister(
                                  UserInfoRequestDTO(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: '',
                                  ),
                                );
                                if (registerCubit.state is RegisterSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const DSSnackBar(
                                      message:
                                          'Solicitação enviada com sucesso!',
                                    ).build,
                                  );
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              }),
                        );
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _codeVerification() {
    codeConfirmationCubit.sendRequest(
      emailCubit.email,
    );
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0).copyWith(top: 0),
            child: DSDefaultCardDialogContent(
              title: 'Verificação de código',
              subtitle:
                  'Quase lá só falta confirmar seu email, enviamos um código para o email que você cadastrou, por favor insira o código abaixo',
              middleCustomContent: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder(
                        bloc: codeConfirmationCubit,
                        builder: (context, state) {
                          return AppDSTextField(
                            controller: codeController,
                            errorMsg: () {
                              if (state is CodeConfirmationErrorState) {
                                return state.message;
                              }
                            }(),
                            hintText: 'código de verificação',
                            onChange: (value) {
                              codeConfirmationCubit.validateCode(value);
                            },
                          );
                        }),
                  ],
                ),
              ),
              buttons: [
                Column(
                  children: [
                    BlocBuilder(
                        bloc: codeConfirmationCubit,
                        builder: (context, state) {
                          return Row(
                            children: [
                              Expanded(
                                child: StreamBuilder(
                                    stream: codeConfirmationCubit
                                        .timeToResend.stream,
                                    builder: (context, snapshot) {
                                      return DSCustomButton(
                                          type: () {
                                            if (snapshot.hasData &&
                                                snapshot.data as int > 0) {
                                              return DSCustomButtonTypes
                                                  .outline;
                                            }
                                            return DSCustomButtonTypes.solid;
                                          }(),
                                          padding: EdgeInsets.zero,
                                          text: () {
                                            if (snapshot.hasData &&
                                                snapshot.data as int > 0) {
                                              return 'Tentar novamente em (${snapshot.data})';
                                            }
                                            return 'Reenviar código';
                                          }(),
                                          isLoading: () {
                                            if (state
                                                is CodeConfirmationLoadingState) {
                                              return true;
                                            }
                                            return false;
                                          }(),
                                          enabled: () {
                                            if (state
                                                is CodeConfirmationLoadingState) {
                                              return false;
                                            }
                                            if (snapshot.hasData &&
                                                snapshot.data as int > 0) {
                                              return false;
                                            }
                                            return true;
                                          }(),
                                          onTap: () {
                                            codeConfirmationCubit.sendRequest(
                                              emailCubit.email,
                                            );
                                          });
                                    }),
                              ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder(
                        bloc: codeConfirmationCubit,
                        builder: (context, state) {
                          return Row(
                            children: [
                              Expanded(
                                child: DSCustomButton(
                                    type: DSCustomButtonTypes.outline,
                                    padding: EdgeInsets.zero,
                                    text: 'Confirmar',
                                    isLoading: false,
                                    enabled: () {
                                      if (state
                                          is CodeConfirmationLoadingState) {
                                        return false;
                                      }
                                      if (state is CodeConfirmationErrorState) {
                                        return false;
                                      }
                                      return true;
                                    }(),
                                    onTap: () {
                                       codeConfirmationCubit.sendRequest(
                                        emailCubit.email,
                                      );
                                    }),
                              ),
                            ],
                          );
                        }),
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
