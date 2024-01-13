import '../../common/models/account.dart';
import '../../common/models/credentials.dart';
import '../../core/http/core_http.dart';

abstract class AuthRepository {
  Future<Account> auth(Credentials credentials);
}

class AuthRepositoryImp implements AuthRepository {
  CoreHttp coreHttp;

  AuthRepositoryImp(this.coreHttp);

  @override
  Future<Account> auth(Credentials credentials) async {
    var response = await coreHttp.post(
      route: '/account/login',
      body: credentials.toJson(),
    );
    if (response.statusCode! > 499) {
      throw 'Servidor indisponível';
    }
    coreHttp.addHeader(
      'Authorization',
      'Bearer ${response.data['token']}',
    );
    return Account.fromJson(response.data);
  }
}
