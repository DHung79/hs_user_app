import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../core/base/models/upload_image.dart';
import '../../../../../core/user/user.dart';
import '../../../../../main.dart';
import '../../../../../theme/validator_text.dart';

class EditForm extends StatefulWidget {
  final UserModel editModel;
  const EditForm({Key? key, required this.editModel}) : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  String _errorMessage = '';
  late EditUserModel _editModel;
  final _userBloc = UserBloc();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final List<UploadImage> _images = [];

  // Implementing the image picker

  @override
  void initState() {
    _editModel = EditUserModel.fromModel(widget.editModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          autovalidateMode: _autovalidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              avatar(),
              inputField(),
              confirmbutton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField() {
    return Column(
      children: [
        formprofile(
          initialValue: _editModel.name,
          color: AppColor.text3,
          name: 'Tên hiển thị',
          onSaved: (value) {
            _editModel.name = value!.trim();
          },
          onChanged: (value) {
            setState(() {
              if (_errorMessage.isNotEmpty) {
                _errorMessage = '';
              }
            });
          },
          validator: (value) {
            if (value!.isEmpty || value.trim().isEmpty) {
              return ValidatorText.empty(
                  fieldName: ScreenUtil.t(I18nKey.name)!);
            }
            return null;
          },
        ),
        Row(
          children: [
            Expanded(
              child: formprofile(
                keyboardType: TextInputType.number,
                initialValue: _editModel.phoneNumber,
                color: AppColor.text3,
                name: 'Số điện thoại',
                onSaved: (value) {
                  _editModel.phoneNumber = value!.trim();
                },
                onChanged: (value) {
                  setState(() {
                    if (_errorMessage.isNotEmpty) {
                      _errorMessage = '';
                    }
                  });
                },
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return ValidatorText.empty(
                        fieldName: ScreenUtil.t(I18nKey.phoneNumber)!);
                  }
                  String pattern =
                      r'^(\+843|\+845|\+847|\+848|\+849|\+841|03|05|07|08|09|01[2|6|8|9])+([0-9]{8})$';
                  RegExp regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value)) {
                    return ScreenUtil.t(I18nKey.invalidPhoneNumber)!;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              child: DropdownButton(
                focusColor: AppColor.primary1,
                value: _editModel.gender == "female"
                    ? "Nữ"
                    : _editModel.gender == "male"
                        ? "Nam"
                        : "Khác",
                items: <String>[
                  'Nữ',
                  'Nam',
                  'Khác',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _editModel.gender = newValue!;

                    if (newValue == 'Nam') {
                      _editModel.gender = 'male';
                    } else if (newValue == 'Nữ') {
                      _editModel.gender = 'female';
                    } else {
                      _editModel.gender = 'Others';
                    }
                  });
                },
              ),
            )
          ],
        ),
        formprofile(
          initialValue: _editModel.address,
          color: AppColor.text3,
          name: 'Địa chỉ',
          onSaved: (value) {
            _editModel.address = value!.trim();
          },
          onChanged: (value) {
            setState(() {
              if (_errorMessage.isNotEmpty) {
                _errorMessage = '';
              }
            });
          },
          validator: (value) {
            if (value!.isEmpty || value.trim().isEmpty) {
              return ValidatorText.empty(
                  fieldName: ScreenUtil.t(I18nKey.address)!);
            }
            return null;
          },
        ),
      ],
    );
  }

  Padding avatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 39),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50), // Image border
            child: SizedBox.fromSize(
              size: const Size.fromRadius(50),
              // size: Size.fromRadius(40), // Image radius
              child: _images.isNotEmpty
                  ? Image.memory(
                      _images.first.imageData!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : _editModel.avatar.isNotEmpty
                      ? Image.network(
                          _editModel.avatar,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/logo.png",
                          width: 100,
                          height: 100,
                        ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: AppColor.text3),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Text(
                  'Tải lên ảnh',
                  style: AppTextTheme.normalText(AppColor.text3),
                ),
              ),
              onPressed: () {
                setState(() {
                  _errorMessage = '';
                });
                _pickImage();
              },
            ),
          ),
        ],
      ),
    );
  }

  _editUserInfo() {
    _userBloc.editProfile(editModel: _editModel).then(
      (value) async {
        if (_images.isNotEmpty) {
          _uploadImage();
        } else {
          AuthenticationBlocController().authenticationBloc.add(GetUserData());
          navigateTo(settingProfileRoute);
          JTToast.successToast(message: ScreenUtil.t(I18nKey.updateSuccess)!);
        }
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {
        _errorMessage = showError(error.errorCode, context);
      });
    }).catchError(
      (error, stackTrace) {
        setState(() {
          _errorMessage = error.toString();
        });
      },
    );
  }

  Widget confirmbutton() {
    return SizedBox(
      height: 52,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: AppColor.primary2),
        onPressed: () {
          if (_key.currentState!.validate()) {
            _key.currentState!.save();
            _editUserInfo();
          } else {
            setState(() {
              _autovalidate = AutovalidateMode.onUserInteraction;
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              SvgIcons.checkCircleOutline,
              color: AppColor.text2,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Xác nhận',
                style: AppTextTheme.headerTitle(AppColor.text2),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding formprofile(
      {required String name,
      required Color color,
      String? initialValue,
      void Function(String?)? onSaved,
      void Function(String)? onChanged,
      String? Function(String?)? validator,
      List<TextInputFormatter>? inputFormatters,
      TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextTheme.mediumHeaderTitle(color),
          ),
          Container(
            constraints: const BoxConstraints(minHeight: 50),
            margin: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              keyboardType: keyboardType,
              onSaved: onSaved,
              onChanged: onChanged,
              validator: validator,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
              style: AppTextTheme.normalText(AppColor.text7),
              decoration: InputDecoration(
                hintStyle: AppTextTheme.normalText(AppColor.text7),
                contentPadding: const EdgeInsets.only(left: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _pickImage() async {
    List<XFile?> imagesPicked = [];
    final ImagePicker _picker = ImagePicker();
    imagesPicked = [await _picker.pickImage(source: ImageSource.gallery)];
    if (imagesPicked.isNotEmpty) {
      final images = imagesPicked
          .map(
            (image) async => UploadImage(
              key: '${DateTime.now().millisecondsSinceEpoch}-${image!.name}',
              name: image.name,
              path: image.path,
              imageData: await image.readAsBytes(),
            ),
          )
          .toList();
      final image = await images.first;
      setState(() {
        _images.clear();
        _images.add(image);
      });
    }
  }

  _uploadImage() {
    _userBloc.uploadImage(image: _images.first).then((value) {
      AuthenticationBlocController().authenticationBloc.add(GetUserData());
      navigateTo(profileUserRoute);
      JTToast.successToast(message: ScreenUtil.t(I18nKey.updateSuccess)!);
    }).onError((ApiError error, stackTrace) {
      setState(() {
        _errorMessage = 'Ảnh không đúng định dạng';
      });
    }).catchError(
      (error, stackTrace) {
        setState(() {
          _errorMessage = error.toString();
        });
      },
    );
  }
}
