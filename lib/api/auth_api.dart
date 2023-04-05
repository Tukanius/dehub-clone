import 'package:dehub/utils/http_request.dart';
import '../models/user.dart';

class AuthApi extends HttpRequest {
  login(User user) async {
    var res = await post('/auth/login', data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }
}
