import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class ServiceModel extends BaseModel {
  final String __id;
  final String _name;
  final List<TranslationModel> _translations = [];
  final String _image;
  final bool _isValid;
  final List<OptionsModel> _options = [];
  final List<PaymentsModel> _payments = [];
  final int _createdTime;
  final int _updatedTime;
  final String _code;

  ServiceModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _name = json['name'] ?? '',
        _code = json['code'] ?? '',
        _image = json['image'] ?? '',
        _isValid = json['isValid'] ?? false,
        _createdTime = json['created_time'] ?? 0,
        _updatedTime = json['updated_time'] ?? 0 {
    _translations.addAll(BaseModel.mapList<TranslationModel>(
      json: json,
      key: 'translation',
    ));
    _payments.addAll(BaseModel.mapList<PaymentsModel>(
      json: json,
      key: 'payments',
    ));
    _options.addAll(BaseModel.mapList<OptionsModel>(
      json: json,
      key: 'option',
    ));
  }

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'name': _name,
        'code': _code,
        'image': _image,
        'isValid': _isValid,
        'created_time': _createdTime,
        'updated_time': _updatedTime,
        'translation': _translations.map((e) => e.toJson()).toList(),
        'options': _options.map((e) => e.toJson()).toList(),
        'payments': _payments.map((e) => e.toJson()).toList(),
      };

  String get id => __id;
  String get name => _name;
  String get code => _code;
  String get image => _image;
  bool get isValid => _isValid;
  int get createdTime => _createdTime;
  int get updatedTime => _updatedTime;
  List<TranslationModel> get translations => _translations;
  List<OptionsModel> get options => _options;
  List<PaymentsModel> get payments => _payments;

}

class EditServiceModel extends EditBaseModel {
  String id = ''; // For editing
  String name = '';
  String code = '';
  String image = '';
  bool isValid = false;
  CategoryModel? categoryModel;
  int createdTime = 0;
  int updatedTime = 0;
  List<TranslationModel> translations = [];
  List<OptionsModel> options = [];
  List<OptionsModel> payments = [];

  EditServiceModel.fromModel(ServiceModel? model) {
    id = model?.id ?? '';
    name = model?.name ?? '';
    code = model?.code ?? '';
    image = model?.image ?? '';
    isValid = model?.isValid ?? false;
    createdTime = model?.createdTime ?? 0;
    updatedTime = model?.updatedTime ?? 0;
    translations = model?.translations ?? [];
    options = model?.options ?? [];
  }

  Map<String, dynamic> toCreateJson() {
    Map<String, dynamic> params = {
      'name': name,
      'code': code,
      'image': image,
      'isValid': isValid,
      'categoryModel': categoryModel,
      'translations': translations,
      'options': options,
      'payments': payments,
    };

    return params;
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'id': id,
      'name': name,
      'code': code,
      'image': image,
      'isValid': isValid,
      'categoryModel': categoryModel,
      'translations': translations,
      'options': options,
      'payments': payments,
    };
    return params;
  }
}

class ListServiceModel extends BaseModel {
  List<ServiceModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListServiceModel.fromJson(Map<String, dynamic> parsedJson) {
    List<ServiceModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<ServiceModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<ServiceModel> get records => _data;
  Paging get meta => _metaData;
}

class CategoryModel extends BaseModel {
  final List _translation;
  final List _unit;

  CategoryModel.fromJson(Map<String, dynamic> json)
      : _translation = json['translation'] ?? [],
        _unit = json['unit'] ?? [];

  Map<String, dynamic> toJson() => {
        'translation': _translation,
        'unit': _unit,
      };

  List get translation => _translation;
  List get unit => _unit;
}

class TranslationModel extends BaseModel {
  final String _language;
  final String _name;
  final String __id;

  TranslationModel.fromJson(Map<String, dynamic> json)
      : _language = json['language'] ?? '',
        _name = json['name'] ?? '',
        __id = json['_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'language': _language,
        'name': _name,
        '_id': __id,
      };

  String get language => _language;
  String get name => _name;
  String get id => __id;
}

class OptionsModel extends BaseModel {
  final int _name;
  final int _price;
  final int _quantity;
  final String _note;
  final String __id;

  OptionsModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? 0,
        _price = json['price'] ?? 0,
        _quantity = json['quantity'] ?? 0,
        _note = json['note'] ?? '',
        __id = json['_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': _name,
        'price': _price,
        'quantity': _quantity,
        'note': _note,
        '_id': __id,
      };
  int get name => _name;
  int get price => _price;
  int get quantity => _quantity;
  String get note => _note;
  String get id => __id;
}

class PaymentsModel extends BaseModel {
  final String _name;
  final bool _isActive;
  final String __id;

  PaymentsModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? '',
        _isActive = json['is_active'],
        __id = json['_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': _name,
        'is_active': _isActive,
        '_id': __id,
      };
  String get name => _name;
  bool get isActive => _isActive;
  String get id => __id;
}

class UnitModel extends BaseModel {
  final String _name;
  final List<TranslationModel> _translations = [];

  UnitModel.fromJson(Map<String, dynamic> json) : _name = json['name'] ?? '' {
    _translations.addAll(BaseModel.mapList<TranslationModel>(
      json: json,
      key: 'translation',
    ));
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'translation': _translations.map((e) => e.toJson()).toList(),
      };

  String get name => _name;
  List<TranslationModel> get translations => _translations;
}
