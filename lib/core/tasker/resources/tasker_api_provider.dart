import 'dart:async';
import '../../../main.dart';
import '../../constants/api_constants.dart';
import '../../helpers/api_helper.dart';
import '../../rest/rest_api_handler_data.dart';

class TaskerApiProvider {
  Future<ApiResponse<T?>> fetchUserById<T extends BaseModel>({
    String? id,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.taskers +
        '/$id';

    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.getData<T>(
      path: path,
      headers: ApiHelper.headers(token),
    );
    return response;
  }
}
