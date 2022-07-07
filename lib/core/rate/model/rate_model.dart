import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class RateModel extends BaseModel {
  final String __id;
  final List<MedalModel> _medals = [];
  final List<CommentsModel> _comments = [];

  RateModel.fromJson(Map<String, dynamic> json) : __id = json['_id'] ?? '' {
    _medals.addAll(
      BaseModel.mapList<MedalModel>(
        json: json,
        key: 'medal',
      ),
    );
    _comments.addAll(
      BaseModel.mapList<CommentsModel>(
        json: json,
        key: 'comments',
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'medal': _medals,
        'comments': _comments,
      };

  String get id => __id;
  List<MedalModel> get medal => _medals;
  List<CommentsModel> get comments => _comments;
}

class MedalModel extends BaseModel {
  final String __id;
  final String _name;
  final int _total;

  MedalModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _name = json['name'] ?? '',
        _total = json['total'] ?? 0;

  Map<String, dynamic> toJson() => {
        "_id": __id,
        "name": _name,
        "total": _total,
      };

  String get id => __id;
  String get name => _name;
  int get total => _total;
}

class CommentsModel extends BaseModel {
  // final UserModel _user;
  final String _description;
  final double _rating;
  // final String __id;

  CommentsModel.fromJson(Map<String, dynamic> json)
      // : _user = BaseModel.map<UserModel>(
      //     json: json,
      //     key: 'user',
      //   ),
      : _description = json['description'] ?? '',
        _rating = json['rating'] is int
            ? json['rating'].toDouble()
            : json['rating'] ?? 0;
  // __id = json['id'] ?? '';

  Map<String, dynamic> toJson() => {
        // "user": _user.toJson(),
        "description": _description,
        "rating": _rating,
        // "_id": __id,
      };

  // UserModel get user => _user;
  String get description => _description;
  double get rating => _rating;
  // String get id => __id;
}

class EditRateModel extends EditBaseModel {
  List<CommentsModel> comments = [];

  EditRateModel.fromModel(RateModel? model) {
    comments = model?.comments ?? [];
  }

  Map<String, dynamic> toCreateJson() {
    Map<String, dynamic> params = {
      'comments': comments,
    };
    return params;
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'comments': comments,
    };

    return params;
  }
}

class ListRateModel extends BaseModel {
  List<RateModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListRateModel.fromJson(Map<String, dynamic> parsedJson) {
    List<RateModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<RateModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<RateModel> get records => _data;
  Paging get meta => _metaData;
}
