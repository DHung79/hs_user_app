import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class NotificationModel extends BaseModel {
  final String __id;
  final String _title;
  final String _body;
  final String _user;
  final String _taskId;
  final bool _read;
  final int _createdTime;
  final int _updatedTime;
  final int _totalUnreadNoti;

  NotificationModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _title = json['title'] ?? '',
        _body = json['body'] ?? '',
        _user = json['user'] ?? '',
        _taskId = json['taskId'] ?? '',
        _read = json['read'] ?? false,
        _createdTime = json['created_time'] ?? 0,
        _updatedTime = json['updated_time'] ?? 0,
        _totalUnreadNoti = json['totalUnreadNoti'] ?? 0;

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'title': _title,
        'body': _body,
        'user': _user,
        'taskId': _taskId,
        'read': _read,
        'created_time': _createdTime,
        'updated_time': _updatedTime,
        'totalUnreadNoti': _totalUnreadNoti,
      };

  String get id => __id;
  String get title => _title;
  String get body => _body;
  String get user => _user;
  String get taskId => _taskId;
  bool get read => _read;
  int get createdTime => _createdTime;
  int get updatedTime => _updatedTime;
  int get totalUnreadNoti => _totalUnreadNoti;
}

class NotificationListModel extends BaseModel {
  List<NotificationModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  NotificationListModel.fromJson(Map<String, dynamic> parsedJson) {
    List<NotificationModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<NotificationModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<NotificationModel> get records => _data;
  Paging get meta => _metaData;
}
