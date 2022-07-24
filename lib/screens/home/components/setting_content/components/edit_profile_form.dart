import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../core/base/models/upload_image.dart';
import '../../../../../core/user/user.dart';
import '../../../../../main.dart';
import '../../../../../theme/validator_text.dart';
import '../../../../../widgets/error_message.dart';

class EditProfileForm extends StatefulWidget {
  final UserModel user;
  const EditProfileForm({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  String _errorMessage = '';
  late EditUserModel _editModel;
  final _userBloc = UserBloc();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final List<UploadImage> _images = [];

  @override
  void initState() {
    JTToast.init(context);
    _editModel = EditUserModel.fromModel(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode: _autovalidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
            child: inputField(),
          ),
          ErrorMessage(errorMessage: _errorMessage),
          confirmbutton(),
        ],
      ),
    );
  }

  Widget inputField() {
    return Wrap(
      runSpacing: 24,
      children: [
        _buildInput(
          initialValue: _editModel.name,
          name: 'Tên hiển thị',
          hintText: 'Nhập tên hiển thị',
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
            if (value.trim().length < 5) {
              return ValidatorText.atLeast(
                  fieldName: ScreenUtil.t(I18nKey.name)!, atLeast: 5);
            }
            if (value.trim().length > 50) {
              return ValidatorText.moreThan(
                  fieldName: ScreenUtil.t(I18nKey.name)!, moreThan: 50);
            }
            return null;
          },
        ),
        _buildInput(
          keyboardType: TextInputType.number,
          initialValue: _editModel.phoneNumber,
          name: 'Số điện thoại',
          hintText: 'Nhập số điện thoại',
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
        _buildInput(
          initialValue: _editModel.address,
          name: 'Địa chỉ',
          hintText: 'Nhập địa chỉ',
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
            if (value.trim().length < 5) {
              return ValidatorText.atLeast(
                  fieldName: ScreenUtil.t(I18nKey.address)!, atLeast: 5);
            }
            if (value.trim().length > 300) {
              return ValidatorText.moreThan(
                  fieldName: ScreenUtil.t(I18nKey.address)!, moreThan: 300);
            }
            return null;
          },
        ),
      ],
    );
  }

  Padding avatar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 31, 0, 23),
      child: Column(
        children: [
          ClipOval(
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
          await Future.delayed(const Duration(milliseconds: 400));
          navigateTo(userProfileRoute);
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

  Widget _buildInput({
    required String name,
    String? hintText,
    TextEditingController? controller,
    String? initialValue,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextTheme.mediumHeaderTitle(AppColor.text3),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 50),
          margin: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            controller: controller,
            initialValue: initialValue,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: AppTextTheme.normalText(AppColor.text3),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextTheme.normalText(AppColor.text7),
              contentPadding: const EdgeInsets.only(left: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.text7),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.text7),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onSaved: onSaved,
            onChanged: onChanged,
            validator: validator,
          ),
        )
      ],
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
    _userBloc.uploadImage(image: _images.first).then((value) async {
      AuthenticationBlocController().authenticationBloc.add(GetUserData());
      await Future.delayed(const Duration(milliseconds: 400));
      navigateTo(userProfileRoute);
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
