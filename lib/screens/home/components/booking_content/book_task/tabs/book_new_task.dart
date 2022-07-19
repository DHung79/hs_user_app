import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../../../core/service/service.dart';
import '../../../../../../theme/validator_text.dart';
import '../../../../../../widgets/task_widget/task_widget.dart';
import '../components/components.dart';
import '/core/task/task.dart';
import '/main.dart';
import 'package:intl/intl.dart';
import '/core/user/user.dart';

class BookNewTaskContent extends StatefulWidget {
  final UserModel user;
  const BookNewTaskContent({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<BookNewTaskContent> createState() => _BookNewTaskContentState();
}

class _BookNewTaskContentState extends State<BookNewTaskContent> {
  final _taskBloc = TaskBloc();
  final _serviceBloc = ServiceBloc();
  final _userBloc = UserBloc();
  final _scrollController = ScrollController();
  late final EditTaskModel _editTaskModel;
  late final EditUserModel _editUserModel;
  final _locationController = TextEditingController();
  final _noteController = TextEditingController();
  final _addressController = TextEditingController();
  final _subNameController = TextEditingController();
  bool _isCreateTask = true;
  bool _isEditCheckList = false;
  int _tab = 0;

  @override
  void initState() {
    JTToast.init(context);
    _fetchDataOnPage();
    _editTaskModel = EditTaskModel.fromModel(null);
    _editUserModel = EditUserModel.fromModel(widget.user);
    if (_editTaskModel.checkList.isNotEmpty) {
      _isEditCheckList = true;
    }
    final _now = DateTime.now();
    _editTaskModel.date = DateTime(_now.year, _now.month, _now.day, 0, 0, 0)
        .millisecondsSinceEpoch;
    _editTaskModel.startTime = _now.millisecondsSinceEpoch;
    _locationController.text = _editTaskModel.address.name;
    super.initState();
  }

  @override
  void dispose() {
    _serviceBloc.dispose();
    _taskBloc.dispose();
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    if (_tab == 1) {
      return EditUserInfo(
        editUserModel: _editUserModel,
        userBloc: _userBloc,
        goBack: (user) {
          setState(() {
            _tab = 0;
          });
        },
      );
    } else if (_tab == 2) {
      return SearchLocation(
        locationController: _locationController,
        changeLocation: (location) {
          setState(() {
            _locationController.text = location;
            _editTaskModel.address.name = location;
          });
        },
        openPickLocation: () {
          setState(() {
            _tab = 3;
          });
        },
        goBack: () {
          setState(() {
            _tab = 0;
          });
        },
      );
    } else if (_tab == 3) {
      return PickLocation(
        locationController: _locationController,
        selectedLocation: ({String lat = '', String long = ''}) {
          setState(() {
            _editTaskModel.address.lat = lat;
            _editTaskModel.address.long = long;
          });
        },
        changeLocation: (location) {
          setState(() {
            _locationController.text = location;
            _editTaskModel.address.name = location;
          });
        },
        goBack: () {
          setState(() {
            _tab = 2;
          });
        },
        goNext: () {
          setState(() {
            _tab = 4;
          });
        },
      );
    } else if (_tab == 4) {
      return AddressInput(
          subNameController: _subNameController,
          addressController: _addressController,
          editTaskModel: _editTaskModel,
          goBack: () {
            setState(() {
              _tab = 3;
            });
          },
          selectedHomeType: (type) {
            setState(() {
              _editTaskModel.typeHome = type;
            });
          },
          onPressed: () {
            setState(() {
              _editTaskModel.address.location = _addressController.text;
              _tab = 0;
            });
          });
    } else {
      return _buildTaskPage();
    }
  }

  Widget _buildTaskPage() {
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
                  if (_isCreateTask) {
                    navigateTo(bookTaskRoute);
                  } else {
                    setState(() {
                      _isCreateTask = true;
                      if (_scrollController.hasClients &&
                          _scrollController.keepScrollOffset) {
                        _scrollController.jumpTo(0);
                      }
                    });
                  }
                },
              ),
              Center(
                child: Text(
                  _isCreateTask ? 'Dọn dẹp nhà cửa' : 'Xác nhận và thanh toán',
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
        StreamBuilder(
          stream: _serviceBloc.allData,
          builder: (context,
              AsyncSnapshot<ApiResponse<ListServiceModel?>> snapshot) {
            if (snapshot.hasData) {
              final service = snapshot.data!.model!.records.first;
              _editTaskModel.service = service;
              _editTaskModel.selectedOption ??= service.options.first;
              _editTaskModel.totalPrice = _editTaskModel.selectedOption!.price;
              return Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: _buildTaskInfo(service),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  Widget _buildTaskInfo(ServiceModel service) {
    final price = NumberFormat('#,##0 VND', 'vi')
        .format(_editTaskModel.selectedOption!.price);
    final screenSize = MediaQuery.of(context).size;
    final startTime = formatFromInt(
      displayedFormat: 'HH:mm',
      value: _editTaskModel.startTime,
      context: context,
    );
    final endTime = formatFromInt(
      displayedFormat: '- HH:mm',
      value: _editTaskModel.endTime,
      context: context,
    );
    final date = formatFromInt(
      displayedFormat: 'E, dd/MM/yyyy',
      value: _editTaskModel.date,
      context: context,
    );
    final optionType =
        getOptionType(_editTaskModel.service!.optionType).toLowerCase();
    return Container(
      constraints: BoxConstraints(
        minHeight: screenSize.height - 80,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              if (_isCreateTask)
                Column(
                  children: [
                    _location(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: _buildOptions(service),
                    ),
                  ],
                ),
              if (_isCreateTask)
                TaskTimePicker(
                  editModel: _editTaskModel,
                  onChangeDate: (date) {
                    setState(() {
                      _editTaskModel.date = date.millisecondsSinceEpoch;
                      final startTimeData = DateTime.fromMillisecondsSinceEpoch(
                        _editTaskModel.startTime.toInt(),
                      );
                      final startTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        startTimeData.hour,
                        startTimeData.minute,
                      );
                      _editTaskModel.startTime =
                          startTime.millisecondsSinceEpoch;
                      final endTime = startTime.add(
                        Duration(
                            hours: _editTaskModel.selectedOption!.quantity),
                      );
                      _editTaskModel.endTime = endTime.millisecondsSinceEpoch;
                    });
                  },
                  onChangeTime: (time) {
                    setState(() {
                      final date = DateTime.fromMillisecondsSinceEpoch(
                        _editTaskModel.date.toInt(),
                      );
                      final startTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                      _editTaskModel.startTime =
                          startTime.millisecondsSinceEpoch;
                      final endTime = startTime.add(
                        Duration(
                            hours: _editTaskModel.selectedOption!.quantity),
                      );
                      _editTaskModel.endTime = endTime.millisecondsSinceEpoch;
                    });
                  },
                ),
              if (!_isCreateTask)
                Column(
                  children: [
                    if (_isCreateTask)
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Divider(),
                      ),
                    _taskDetailField(
                      title: 'Thông tin công việc',
                      onPressed: () {
                        setState(() {
                          _isCreateTask = true;
                        });
                      },
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _detailItem(
                            title:
                                '${_editTaskModel.estimateTime} $optionType, $startTime $endTime',
                            icon: SvgIcons.accessTime,
                          ),
                          _detailItem(
                            title: date,
                            icon: SvgIcons.calenderToday,
                          ),
                          if (_editTaskModel.service != null)
                            _detailItem(
                              title: _editTaskModel.selectedOption!.note,
                              icon: SvgIcons.clipboard1,
                            ),
                          _detailItem(
                            title: _editTaskModel.address.name,
                            icon: SvgIcons.epLocation,
                          ),
                        ],
                      ),
                    ),
                    _taskDetailField(
                      title: 'Thông tin của bạn',
                      onPressed: () {
                        setState(() {
                          _tab = 1;
                        });
                      },
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _detailItem(
                            title: _editUserModel.name,
                            icon: SvgIcons.user1,
                          ),
                          _detailItem(
                            title: _editUserModel.phoneNumber,
                            icon: SvgIcons.telephone1,
                          ),
                        ],
                      ),
                    ),
                    _taskDetailField(
                      title: 'Hình thức thanh toán',
                      onPressed: () {},
                      child: _detailItem(
                        title: 'Thanh toán tiền mặt',
                        icon: SvgIcons.wallet1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng cộng',
                            style:
                                AppTextTheme.mediumHeaderTitle(AppColor.text1),
                          ),
                          Text(
                            price,
                            style: AppTextTheme.mediumBigText(AppColor.text1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (_isCreateTask)
                Column(
                  children: [
                    _noteForTasker(),
                    _checkList(),
                  ],
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 26, 16, 34),
            child: AppButtonTheme.fillRounded(
              constraints: const BoxConstraints(minHeight: 52),
              color: AppColor.shade9,
              borderRadius: BorderRadius.circular(4),
              child: _isCreateTask
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: Text(
                              '$price/${_editTaskModel.selectedOption?.quantity} $optionType',
                              style: AppTextTheme.headerTitle(AppColor.text2),
                            ),
                          ),
                          Text(
                            'TIẾP THEO',
                            style: AppTextTheme.headerTitle(AppColor.text2),
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        'ĐĂNG VIỆC',
                        style: AppTextTheme.headerTitle(AppColor.text2),
                      ),
                    ),
              onPressed: () {
                final _now = DateTime.now();
                if (_editTaskModel.startTime < _now.millisecondsSinceEpoch) {
                  bottomDialog(
                    context,
                    title: 'Thời gian không hợp lệ',
                    content: 'Vui lòng chọn lại thời gian bắt đầu',
                  );
                } else if (_editTaskModel.address.name.isEmpty) {
                  bottomDialog(
                    context,
                    title: 'Địa chỉ không được để trống',
                    content: 'Vui lòng chọn địa chỉ',
                  );
                } else {
                  if (_isCreateTask) {
                    _goToCreateTask();
                  } else {
                    _createTask();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskDetailField({
    required String title,
    required void Function()? onPressed,
    Widget? child,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
              ),
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(minHeight: 38),
                color: AppColor.shade1,
                borderRadius: BorderRadius.circular(50.0),
                onPressed: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Thay đổi',
                    style: AppTextTheme.normalText(AppColor.text3),
                  ),
                ),
              ),
            ],
          ),
          if (child != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: child,
            ),
        ],
      ),
    );
  }

  Widget _detailItem({
    required String title,
    required SvgIconData icon,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColor.shade10,
            borderRadius: BorderRadius.circular(4),
          ),
          child: SvgIcon(
            icon,
            size: 24,
            color: AppColor.shade5,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: AppTextTheme.normalText(AppColor.text1),
            ),
          ),
        )
      ],
    );
  }

  Widget _location() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Địa điểm',
            style: AppTextTheme.mediumHeaderTitle(AppColor.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: () {
              setState(() {
                _tab = 2;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.shadow.withOpacity(0.24),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 19,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    SvgIcon(
                      SvgIcons.locationOn,
                      color: AppColor.black,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _locationController.text.isNotEmpty
                        ? Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _locationController.text,
                                    style: AppTextTheme.normalText(
                                      AppColor.primary1,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Transform.rotate(
                                  angle: 180 * pi / 180,
                                  child: SvgIcon(
                                    SvgIcons.arrowBackIos,
                                    size: 24,
                                    color: AppColor.text1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'Chọn địa chỉ',
                            style: AppTextTheme.normalText(AppColor.text3),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(ServiceModel service) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thời lượng',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: service.options.length,
              itemBuilder: (BuildContext context, int index) {
                final option = service.options[index];
                final isSelected = _editTaskModel.selectedOption == option;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _editTaskModel.selectedOption = option;
                        _editTaskModel.totalPrice = option.price;
                        if (service.optionType == 0) {
                          _editTaskModel.estimateTime = '${option.quantity}';
                          _editTaskModel.endTime =
                              DateTime.fromMillisecondsSinceEpoch(
                                      _editTaskModel.startTime)
                                  .add(Duration(hours: option.quantity))
                                  .millisecondsSinceEpoch;
                        }
                      });
                    },
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 40),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.shadow.withOpacity(0.24),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 16,
                            ),
                          ],
                          border: Border.all(
                            width: 2,
                            color: isSelected
                                ? AppColor.primary2
                                : AppColor.transparent,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                option.name,
                                style: AppTextTheme.normalHeaderTitle(
                                  AppColor.primary1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  option.note,
                                  style:
                                      AppTextTheme.normalText(AppColor.text7),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _noteForTasker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ghi chú cho người làm',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextFormField(
              controller: _noteController,
              style: AppTextTheme.normalText(AppColor.text1),
              maxLines: 8,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.text7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.text7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkList() {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Danh sách công việc',
                    style: AppTextTheme.normalHeaderTitle(AppColor.text1),
                  ),
                  Text(
                    'Tạo danh sách công việc cho người làm',
                    style: AppTextTheme.subText(AppColor.text3),
                  )
                ],
              ),
              Transform.scale(
                scale: 1,
                child: Switch(
                  onChanged: (value) {
                    setState(() {
                      _isEditCheckList = value;
                      _editTaskModel.checkList.clear();
                    });
                  },
                  value: _isEditCheckList,
                  activeColor: AppColor.primary2,
                  activeTrackColor: AppColor.secondary4,
                  inactiveTrackColor: AppColor.background.withOpacity(0.08),
                  inactiveThumbColor: AppColor.white,
                ),
              )
            ],
          ),
          if (_isEditCheckList)
            Column(
              children: [
                for (var item in _editTaskModel.checkList)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      width: screenSize.width - 32,
                      constraints: const BoxConstraints(minHeight: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgIcon(
                                SvgIcons.dragindicator,
                                size: 24,
                                color: AppColor.text1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  item.name,
                                  style:
                                      AppTextTheme.normalText(AppColor.text1),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _editTaskModel.checkList.remove(item);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                SvgIcons.bxTrashAlt,
                                size: 24,
                                color: AppColor.text1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CreateToDoDialog(
                              onPressed: (todo) {
                                setState(() {
                                  _editTaskModel.checkList.add(
                                    CheckListModel.fromJson({
                                      'name': todo,
                                    }),
                                  );
                                });
                              },
                            );
                          });
                    },
                    child: Row(
                      children: [
                        SvgIcon(
                          SvgIcons.add,
                          color: AppColor.text1,
                          size: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            'Thêm mới',
                            style: AppTextTheme.normalText(AppColor.text3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  _fetchDataOnPage() {
    _serviceBloc.fetchAllData(params: {});
  }

  _goToCreateTask() {
    setState(() {
      _isCreateTask = false;
      if (_scrollController.hasClients && _scrollController.keepScrollOffset) {
        _scrollController.jumpTo(0);
      }
    });
  }

  _createTask() {
    _taskBloc.createTask(editModel: _editTaskModel).then(
      (value) async {
        navigateTo(bookTaskRoute);
        JTToast.successToast(message: ScreenUtil.t(I18nKey.updateSuccess)!);
      },
    ).onError((ApiError error, stackTrace) {
      JTToast.errorToast(message: showError(error.errorCode, context));
    }).catchError(
      (error, stackTrace) {
        logDebug('catchError: $error');
      },
    );
  }
}
