import 'package:flutter/material.dart';
import 'components.dart';

class AddressInput extends StatefulWidget {
  final EditTaskModel editTaskModel;
  final Function() goBack;
  final Function(int) selectedHomeType;
  final Function() onPressed;
  final TextEditingController subNameController;
  final TextEditingController addressController;
  const AddressInput({
    Key? key,
    required this.goBack,
    required this.editTaskModel,
    required this.selectedHomeType,
    required this.subNameController,
    required this.addressController,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AddressInput> createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  final List _homeTypes = ['Nhà ở', 'Căn hộ', 'Biệt thự'];
  final _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadow.withOpacity(0.16),
                blurRadius: 16,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(minHeight: 56, maxWidth: 40),
                color: AppColor.transparent,
                highlightColor: AppColor.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgIcon(
                    SvgIcons.arrowBack,
                    size: 24,
                    color: AppColor.black,
                  ),
                ),
                onPressed: () {
                  widget.goBack();
                },
              ),
              Center(
                child: Text(
                  'Chọn loại nhà, số nhà',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
              ),
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(maxWidth: 40),
                color: Colors.transparent,
                highlightColor: AppColor.white,
                child: const SizedBox(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenSize.height - 90 - bottomHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _key,
                autovalidateMode: _autovalidate,
                child: _buildContent(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
            //   child: TextAreaInput(
            //     title: 'Tên địa chỉ',
            //     controller: widget.subNameController,
            //     maxLines: 1,
            //     hintText: 'Nhập tên địa chỉ',
            //     hintStyle: AppTextTheme.normalText(AppColor.text7),
            //     validator: (value) {
            //       if (value!.trim().isEmpty) {
            //         return ValidatorText.empty(fieldName: 'Tên địa chỉ');
            //       }
            //       if (value.trim().length > 50) {
            //         return ValidatorText.moreThan(
            //           fieldName: 'Tên địa chỉ',
            //           moreThan: 50,
            //         );
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Loại nhà',
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _homeTypes.length,
              itemBuilder: (BuildContext context, int index) {
                final homeType = _homeTypes[index];
                return _typeHomeList(
                  isSelected: index == widget.editTaskModel.typeHome,
                  homeType: homeType,
                  onTap: () {
                    widget.selectedHomeType(index);
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextAreaInput(
                title: 'Địa chỉ cụ thể',
                controller: widget.addressController,
                maxLines: 4,
                hintText: 'Số nhà 1, hẻm 2',
                hintStyle: AppTextTheme.normalText(AppColor.text7),
                validator: (value) {
                  if (value!.isEmpty) {
                    return ValidatorText.empty(fieldName: 'Địa chỉ cụ thể');
                  }
                  return null;
                },
              ),
            ),
            Text(
              '*Nhập địa chỉ cụ thể để người giúp việc có thể tìm chính xác nơi làm việc',
              style: AppTextTheme.normalText(AppColor.text1),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: AppButtonTheme.fillRounded(
            constraints: const BoxConstraints(minHeight: 52),
            color: AppColor.primary2,
            highlightColor: AppColor.transparent,
            borderRadius: BorderRadius.circular(4),
            child: Center(
              child: Text(
                'Đồng ý'.toUpperCase(),
                style: AppTextTheme.headerTitle(AppColor.text2),
              ),
            ),
            onPressed: () {
              if (_key.currentState!.validate()) {
                _key.currentState!.save();
                widget.onPressed();
              } else {
                setState(() {
                  _autovalidate = AutovalidateMode.onUserInteraction;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _typeHomeList({
    required bool isSelected,
    Function()? onTap,
    required String homeType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        child: Container(
          constraints: const BoxConstraints(minHeight: 42),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColor.primary1 : AppColor.text7,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  homeType,
                  style: AppTextTheme.normalText(
                      isSelected ? AppColor.primary1 : AppColor.text3),
                ),
              ],
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
