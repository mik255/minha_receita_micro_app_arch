import '../../../../common/models/account.dart';
import '../../../../common/models/credentials.dart';
import '../../../../core/http/core_http.dart';
import '../dto/register_dto.dart';

abstract class IAccountRepository {
  Future<Account> auth(Credentials credentials);

  Future<String> sendRequestCode(email);

  Future<Account> confirmRequestCode(String code);

  Future<void> sendUserInfo(UserInfoRequestDTO dto);
}

class AuthRepositoryImp implements IAccountRepository {
  CoreHttp coreHttp;

  AuthRepositoryImp(this.coreHttp);

  @override
  Future<Account> auth(Credentials credentials) async {
    var response = await coreHttp.post(
      route: '/account/auth',
      body: credentials.toJson(),
    );
    if (response.statusCode! > 499) {
      throw 'Servidor indisponível';
    }
    coreHttp.addHeader(
      'Authorization',
      'Bearer ${response.data['token']}',
    );
    try {
      return Account.fromJson(response.data);
    } catch (e, s) {
      print(s);
      throw 'Erro ao mappear os dados do usuário ${e.toString()}';
    }
  }

  @override
  Future<String> sendRequestCode(email) async {
    try {
      var response = await coreHttp.post(
        route: '/account/register/requestCode',
        body: {'email': email},
      );
      if (response.statusCode! > 400 && response.statusCode! < 500) {
        throw 'Código inválido';
      }
      if(response.statusCode! > 500){
        throw 'Servidor indisponível, verifique a sua internet ou tente novamente mais tarde.';
      }
      return response.data['code'].toString();
    } catch (e, s) {
      print(s);
      throw e.toString();
    }
  }

  @override
  Future<Account> confirmRequestCode(String code) async {
    try {
      var response = await coreHttp.post(
        route: '/account/register/confirmCode',
        body: {'code': code},
      );
      if (response.statusCode == 401) {
        throw 'Código inválido';
      }
      return Account.fromJson(response.data);
    } catch (e, s) {
      print(s);
      throw 'Erro desconhecido, verifique a sua internet ou tente novamente mais tarde.';
    }
  }

  @override
  Future<void> sendUserInfo(UserInfoRequestDTO dto) async {
    try {
      await coreHttp.post(
        route: '/account/register/userInfo',
        body: dto.toJson(),
      );
    } catch (e, s) {
      print(s);
      throw 'Erro desconhecido, verifique a sua internet ou tente novamente mais tarde.';
    }
  }
}
