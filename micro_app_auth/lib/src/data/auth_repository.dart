import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_core/micro_app_core.dart';

class AuthRepositoryImp {
  CoreHttp coreHttp;

  AuthRepositoryImp(this.coreHttp);

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
