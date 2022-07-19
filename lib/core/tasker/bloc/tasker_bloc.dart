import 'package:rxdart/rxdart.dart';
import '../../../main.dart';
import '../../base/blocs/block_state.dart';
import '../../rest/api_helpers/api_exception.dart';
import '../model/tasker_model.dart';
import '../resources/tasker_repository.dart';

class TaskerBloc {
  final _repository = TaskerRepository();
  final BehaviorSubject<ApiResponse<ListTaskerModel?>> _allDataFetcher =
      BehaviorSubject<ApiResponse<ListTaskerModel>>();
  final _allDataState = BehaviorSubject<BlocState>();

  Stream<ApiResponse<ListTaskerModel?>> get allData => _allDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;

  Future<TaskerModel>? fetchDataById(String id) async {
    try {
      // Await response from server.
      final data =
          await _repository.fetchDataById<TaskerModel, EditTaskerModel>(id: id);
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  dispose() {
    _allDataFetcher.close();
    _allDataState.close();
  }
}
