import 'package:rxdart/rxdart.dart';
import '../../../main.dart';
import '../../base/blocs/block_state.dart';
import '../../rest/api_helpers/api_exception.dart';
import '../tasker.dart';

class TaskerBloc {
  final _repository = TaskerRepository();
  final _allDataFetcher = BehaviorSubject<ApiResponse<ListTaskerModel?>>();
  final _taskerDataFetcher = BehaviorSubject<ApiResponse<TaskerModel?>>();
  final _allDataState = BehaviorSubject<BlocState>();

  Stream<ApiResponse<ListTaskerModel?>> get allData => _allDataFetcher.stream;
  Stream<ApiResponse<TaskerModel?>> get taskerData => _taskerDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;
  bool _isFetching = false;

  fetchAllData({Map<String, dynamic>? params}) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data =
          await _repository.fetchAllData<ListTaskerModel>(params: params!);
      if (_allDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _allDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _allDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _allDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  fetchDataById(String id) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data = await _repository.fetchDataById<TaskerModel>(id: id);
      if (_taskerDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _taskerDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _taskerDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _taskerDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  Future<TaskerModel> ratingTasker({
    required EditReviewModel editModel,
    required String taskId,
  }) async {
    try {
      // Await response from server.
      final data = await _repository.ratingTasker<TaskerModel, EditReviewModel>(
        editModel: editModel,
        taskId: taskId,
      );
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
    _taskerDataFetcher.close();
    _allDataState.close();
  }
}
