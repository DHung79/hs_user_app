import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class NotificationModel extends BaseModel {
  final String _category;
  final bool _isValid;
  final bool _read;
  final int _createdTime;
  final String __id;
  final String _title;
  final String _body;
  final String _user;
  final String _createdAt;

  NotificationModel.fromJson(Map<String, dynamic> json)
      : _category = json['category'] ?? '',
        _isValid = json['isValid'] ?? false,
        _read = json['read'] ?? false,
        _createdTime = json['created_time'],
        __id = json['_id'] ?? '',
        _title = json['title'] ?? '',
        _body = json['body'] ?? '',
        _user = json['user'] ?? '',
        _createdAt = json['createdAt'] ?? '';

  Map<String, dynamic> toJson() => {
        'category': _category,
        'isValid': _isValid,
        'read': _read,
        'created_time': _createdTime,
        '_id': __id,
        'title': _title,
        'body': _body,
        'user': _user,
        'createdAt': _createdAt,
      };

  String get category => _category;
  bool get isValid => _isValid;
  bool get read => _read;
  int get createdTime => _createdTime;
  String get id => __id;
  String get title => _title;
  String get body => _body;
  String get user => _user;
  String get createdAt => _createdAt;
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
