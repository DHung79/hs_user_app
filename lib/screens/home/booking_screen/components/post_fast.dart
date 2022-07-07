import 'package:flutter/material.dart';
import 'package:hs_user_app/core/service/model/service_model.dart';
import 'package:hs_user_app/core/task/task.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/authentication/auth.dart';
import '../../../../core/service/bloc/service_bloc.dart';
import '../../../../core/user/bloc/User_bloc.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../theme/svg_constants.dart';
import '../../../../theme/validator_text.dart';
import '../../../../widgets/button_widget2.dart';
import '../../../../widgets/jt_toast.dart';
import '../../../layout_template/content_screen.dart';
import '../pages/task_page.dart';

final postFastKey = GlobalKey<_PostFastState>();

class PostFast extends StatefulWidget {
  const PostFast({Key? key}) : super(key: key);

  @override
  State<PostFast> createState() => _PostFastState();
}

class _PostFastState extends State<PostFast> {
  final PageState _pageState = PageState();
  int valueWeek = 0;
  int value = 0;
  String note = '';
  int quantity = 0;
  String name = '';
  bool isSwitched = false;
  late EditTaskModel? editModel;
  late DateTime timePick = selectedDate;
  int price = 0;
  DateTime selectedDate = DateTime.now();
  List<ServiceModel>? listOptions;
  final _userBloc = UserBloc();
  final _taskBloc = TaskBloc();
  int? timeSend;
  List<ServiceModel>? options;
  String weekDay = '';
  List<TaskModel>? tasks;
  DateTime today = DateTime.now();
  final _serviceBloc = ServiceBloc();
  List listTask = [];
  TextEditingController noteForTasker = TextEditingController();
  final TextEditingController _addTask = TextEditingController();
  bool _mainPage = true;
  bool _mainPageProfile = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';
  EditUserModel? _editUser;

  _saveList(list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList("key", list);

    return true;
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  final TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        editModel?.startTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          newTime.hour,
          newTime.minute,
        ).millisecondsSinceEpoch;
      });
    }
  }

  @override
  void initState() {
    editModel = EditTaskModel.fromModel(taskPageKey.currentState?.task);
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    _userBloc.getProfile();
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: FutureBuilder(
        future: _pageState.currentUser,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          return PageContent(
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
            child: _mainPage ? content(snapshot) : _editTaskProfile(),
          );
        },
      ),
    );
  }

  Widget _editTaskProfile() {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        elevation: 16,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        backgroundColor: Colors.white,
        leading: BackButton(
            color: AppColor.text1,
            onPressed: () {
              setState(() {
                _mainPage = !_mainPage;
              });
            }),
        title: Text(
          'Chỉnh sửa thông tin công việc',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: _serviceBloc.allData,
          builder: (context,
              AsyncSnapshot<ApiResponse<ListServiceModel?>> snapshot) {
            listOptions = snapshot.data?.model!.records;
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Thời lượng',
                              style: AppTextTheme.mediumHeaderTitle(
                                  AppColor.text1)),
                          const SizedBox(
                            height: 24,
                          ),
                          Column(
                            children: <Widget>[
                              for (int i = 0;
                                  i < listOptions![0].options.length;
                                  i++)
                                room(
                                  listOptions![0].options[i].name,
                                  listOptions![0].options[i].note,
                                  listOptions![0].options[i].quantity,
                                  i,
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          timeWork(),
                        ]),
                  ),
                  listWeek(),
                  const SizedBox(
                    height: 12,
                  ),
                  noteUser(),
                  contentSwitch(),
                  isSwitched == false
                      ? const SizedBox(
                          height: 71,
                        )
                      : Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                constraints: const BoxConstraints(
                                  minHeight: 0,
                                ),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgIcon(
                                                SvgIcons.broom1,
                                                size: 24,
                                                color: AppColor.text1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Text(
                                                  listTask[index],
                                                  style:
                                                      AppTextTheme.normalText(
                                                          AppColor.text1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              minimumSize: const Size(0, 0),
                                              padding: EdgeInsets.zero,
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                listTask
                                                    .remove(listTask[index]);
                                              });
                                            },
                                            child: SvgIcon(
                                              SvgIcons.bxTrashAlt,
                                              size: 24,
                                              color: AppColor.text1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: listTask.length,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: _showMaterialDialog,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgIcon(
                                            SvgIcons.add,
                                            color: AppColor.text1,
                                            size: 24,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            'Thêm mới',
                                            style: AppTextTheme.normalText(
                                                AppColor.text3),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                  payButton(
                    listOptions![0].options[value].price.toString(),
                    listOptions![0].options[value].name.toString(),
                    onPressed: () {
                      setState(() {
                        editModel?.endTime =
                            DateTime.fromMillisecondsSinceEpoch(
                                    editModel!.startTime)
                                .add(
                                  Duration(
                                    hours: int.parse(editModel!.estimateTime),
                                  ),
                                )
                                .millisecondsSinceEpoch;
                        editModel?.date = selectedDate.millisecondsSinceEpoch;
                        editModel?.estimateTime =
                            listOptions![0].options[value].name.toString();
                        note = listOptions![0].options[value].note;
                        quantity = listOptions![0].options[value].quantity;
                        editModel?.note = noteForTasker.text;
                        editModel?.checkList = listTask
                            .map((e) => CheckListModel.fromJson(
                                {'name': e, 'status': false}))
                            .toList();
                        _mainPage = !_mainPage;
                      });
                    },
                  ),
                ],
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColor.primary2,
              ));
            }
          }),
    );
  }

  Widget content(AsyncSnapshot<UserModel> snapshot) {
    final user = snapshot.data;
    _editUser = EditUserModel.fromModel(user);

    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        elevation: 16,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        backgroundColor: Colors.white,
        leading: BackButton(
            color: AppColor.text1,
            onPressed: () {
              setState(() {
                _mainPageProfile
                    ? navigateTo(homeRoute)
                    : _mainPageProfile = !_mainPageProfile;
              });
            }),
        title: Text(
          _mainPageProfile ? 'Đăng việc nhanh' : 'Thông tin cá nhân',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
      ),
      body: _mainPageProfile
          ? StreamBuilder(
              stream: _taskBloc.allData,
              builder: (context,
                  AsyncSnapshot<ApiResponse<ListTaskModel?>> snapshot) {
                tasks = snapshot.data?.model?.records;

                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWork(),
                            ]),
                      ),
                      listWeek(),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: timeStart(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _title(
                                title: 'Thông tin của bạn',
                                onPressed: () {
                                  setState(() {
                                    _mainPageProfile = !_mainPageProfile;
                                  });
                                }),
                            snapshot.hasData
                                ? Column(
                                    children: [
                                      _item(
                                          text: user!.name,
                                          icon: SvgIcons.user1),
                                      _item(
                                          text: user.phoneNumber,
                                          icon: SvgIcons.telephone1),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Text(
                                      'Chưa có thông tin',
                                      style: AppTextTheme.normalText(
                                          AppColor.text8),
                                    ),
                                  ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            _title(
                                title: 'Thông tin công việc',
                                onPressed: () {
                                  setState(() {
                                    _mainPage = !_mainPage;
                                  });
                                }),
                            _item(
                                text:
                                    '${editModel!.estimateTime} tiếng, ${readTimestamp(editModel!.startTime)} đến ${readTimestampEnd(editModel!.startTime)}',
                                icon: SvgIcons.accessTime),
                            _item(
                                text: readTimestamp3(editModel!.date),
                                icon: SvgIcons.calenderToday),
                            if (editModel!.service?.options == [])
                              _item(
                                  text:
                                      '${editModel?.service?.options.first.name}  / ${editModel?.service?.options.first.note} phòng',
                                  icon: SvgIcons.clipboard1),
                            _item(
                                text: editModel!.address,
                                icon: SvgIcons.epLocation),
                            _title(
                                title: 'Hình thức thanh toán',
                                onPressed: () {}),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: AppColor.shade9,
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 16)),
                                onPressed: () {
                                  snapshot.hasData
                                      ? _editTask()
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            content: Container(
                                              width: 334,
                                              height: 400,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              padding: const EdgeInsets.all(24),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Text(
                                                      'Đã nhận việc',
                                                      style: AppTextTheme
                                                          .mediumHeaderTitle(
                                                              AppColor.text1),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        color: AppColor.shade1,
                                                        height: 1,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 16.0),
                                                      ),
                                                      SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Image.asset(
                                                            'assets/images/logo.png',
                                                          )),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        'Đã có người nhận công việc của bạn',
                                                        style: AppTextTheme
                                                            .normalText(
                                                                AppColor.text1),
                                                      ),
                                                      Container(
                                                        height: 8,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 16),
                                                      ),
                                                      ButtonWidget2(
                                                        name: 'Hiểu rồi',
                                                        backgroundColor:
                                                            AppColor.primary2,
                                                        onPressed: () {},
                                                        style: AppTextTheme
                                                            .headerTitle(
                                                                AppColor.text2),
                                                        side: BorderSide.none,
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      ButtonWidget2(
                                                        name: 'Xem công việc',
                                                        backgroundColor:
                                                            AppColor.shade1,
                                                        onPressed: () {},
                                                        style: AppTextTheme
                                                            .headerTitle(
                                                                AppColor.text3),
                                                        side: BorderSide.none,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                },
                                child: Text(
                                  'ĐĂNG VIỆC',
                                  style:
                                      AppTextTheme.headerTitle(AppColor.text2),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primary2,
                    ),
                  );
                }
              },
            )
          : Form(
              key: _key,
              autovalidateMode: _autovalidate,
              child: Column(children: [
                inputProfile(
                  title: 'Tên',
                  initialValue: _editUser?.name,
                  onSaved: (value) {
                    _editUser?.name = value!.trim();
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
                inputProfile(
                  title: 'Số điện thoại',
                  keyboardType: TextInputType.number,
                  initialValue: _editUser?.phoneNumber,
                  onSaved: (value) {
                    _editUser?.phoneNumber = value!.trim();
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
                    return null;
                  },
                ),
                saveButton(
                  name: 'Lưu',
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
                ),
              ]),
            ),
    );
  }

  String readTimestamp(int timestamp) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var time = '';
    time = format.format(date);

    return time;
  }

  String readTimestampEnd(int? timestamp) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp! * 1000);
    var time = '';
    time = format.format(
        date.add(Duration(hours: int.parse(editModel?.estimateTime ?? '0'))));

    return time;
  }

  String readTimestamp2(int timestamp) {
    var format = DateFormat('d');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = '';
    time = format.format(date);

    return time;
  }

  String readTimestamp3(int timestamp) {
    var format = DateFormat('E, dd/MM/yyyy');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var time = '';
    time = format.format(date);

    return time;
  }

  String readDayOfWeek(int timestamp) {
    var format = DateFormat('E');
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var time = '';
    time = format.format(date);

    return time;
  }

  Widget listWeek() {
    List<DateTime> dateTimes = [
      today,
      today.add(const Duration(days: 1)),
      today.add(const Duration(days: 2)),
      today.add(const Duration(days: 3)),
      today.add(const Duration(days: 4)),
      today.add(const Duration(days: 5)),
      today.add(const Duration(days: 6)),
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dateTimes.length,
        itemBuilder: (context, index) {
          return pickTimeWork(
            readTimestamp2(dateTimes[index].millisecondsSinceEpoch),
            readDayOfWeek(dateTimes[index].millisecondsSinceEpoch),
            index,
            dateTimes[index],
          );
        },
      ),
    );
  }

  Container timeStart() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.24),
            blurStyle: BlurStyle.outer,
            blurRadius: 10,
            spreadRadius: 4)
      ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.accessTime,
                  color: AppColor.primary1,
                  size: 24,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Giờ bắt đầu',
                  style: AppTextTheme.normalHeaderTitle(AppColor.text1),
                )
              ],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: AppColor.shade1,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: _selectTime,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 38),
              child: Text(
                readTimestamp(editModel!.startTime),
                style: AppTextTheme.bigText(AppColor.text1),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget pickTimeWork(
      String title, String content, int index, DateTime datePick) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            editModel?.date = datePick.millisecondsSinceEpoch;
            dateActive = editModel!.date;

            if (readTimestamp2(editModel!.date) == datePick.day.toString()) {
              selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day + index);

              editModel?.date = selectedDate.millisecondsSinceEpoch;
            }
          });
        },
        style: TextButton.styleFrom(
          backgroundColor:
              readTimestamp2(editModel!.date) == datePick.day.toString()
                  ? AppColor.primary2
                  : AppColor.text2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: readTimestamp2(editModel!.date) == datePick.day.toString()
              ? const BorderSide(color: Colors.transparent, width: 1)
              : BorderSide(color: AppColor.primary2),
        ),
        child: SizedBox(
          width: 60,
          height: 80,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              title,
              style: readTimestamp2(editModel!.date) == datePick.day.toString()
                  ? AppTextTheme.mediumHeaderTitle(AppColor.text2)
                  : AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              content.toString(),
              style: readTimestamp2(editModel!.date) == datePick.day.toString()
                  ? AppTextTheme.mediumHeaderTitle(AppColor.text2)
                  : AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
          ]),
        ),
      ),
    );
  }

  Row timeWork() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Thời gian làm việc',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        Text(
          'tháng ${DateTime.now().month}, ${DateTime.now().year}',
          style: AppTextTheme.normalHeaderTitle(AppColor.primary1),
        )
      ],
    );
  }

  Widget room(String time, String note, int quantity, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              value = index;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: (value == index)
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.24),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 10,
                        // spreadRadius: 4),
                      ),
                    ],
              border: (value == index)
                  ? Border.all(width: 2, color: AppColor.primary2)
                  : Border.all(width: 2, color: Colors.transparent),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '$time tiếng',
                    style: AppTextTheme.normalHeaderTitle(AppColor.primary1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$note / $quantity phòng',
                    style: AppTextTheme.normalText(AppColor.text7),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          )),
    );
  }

  Widget _title({required String title, required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          TextButton(
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: AppColor.shade1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )),
            onPressed: onPressed,
            child: Text(
              'Thay đổi',
              style: AppTextTheme.normalText(AppColor.text3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({required String text, required SvgIconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
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
                text,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ),
          )
        ],
      ),
    );
  }

  _editTask() {
    // editModel?.address = locationAddress;
    // editModel?.locationGps = LocationGpsModel.fromJson(positionTask);
    // editModel?.startTime = startTime;
    // editModel?.endTime = endTime;
    // editModel?.note = noteTasker;
    // editModel?.checkList = listTaskForTasker;
    // editModel?.date = date;
    // editModel?.typeHome = 'apartment';
    editModel?.endTime =
        DateTime.fromMillisecondsSinceEpoch(editModel!.startTime)
            .add(Duration(hours: int.parse(editModel!.estimateTime)))
            .millisecondsSinceEpoch; 

    _taskBloc.editTask(editModel: editModel).then(
      (value) async {
        navigateTo(homeRoute);
        AuthenticationBlocController().authenticationBloc.add(GetUserData());
        JTToast.successToast(message: ScreenUtil.t(I18nKey.updateSuccess)!);
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {});
    }).catchError(
      (error, stackTrace) {},
    );
  }

  TextButton location() {
    return TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () {
        navigateTo(gpsPageRoute);
      },
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.24),
                blurStyle: BlurStyle.outer,
                blurRadius: 10,
                spreadRadius: 4),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 19, bottom: 19, right: 16, left: 16),
          child: Row(children: [
            SvgIcon(
              SvgIcons.epLocation,
              color: AppColor.primary1,
              size: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            if (locationAddress.isEmpty)
              Text('Chọn địa chỉ',
                  style: AppTextTheme.normalText(AppColor.text3)),
            if (locationAddress.isNotEmpty)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        locationAddress,
                        style: AppTextTheme.normalText(AppColor.primary1),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()
                        ..rotateZ(180 * 3.1415927 / 180),
                      child: SvgIcon(
                        SvgIcons.arrowBackIos,
                        size: 24,
                        color: AppColor.text1,
                      ),
                    ),
                  ],
                ),
              ),
          ]),
        ),
      ),
    );
  }

  Widget noteUser() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(children: [
        timeStart(),
        const SizedBox(
          height: 51,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ghi chú cho người làm',
              style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
            SizedBox(
              height: 144,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: TextField(
                  controller: noteForTasker,
                  style: AppTextTheme.normalText(AppColor.text1),
                  maxLines: 5,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.text7, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.text7, width: 1.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.text7, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.text7, width: 1.0))),
                  cursorColor: AppColor.text1,
                ),
              ),
            )
          ],
        )
      ]),
    );
  }

  Container contentSwitch() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Danh sách công việc',
                style: AppTextTheme.normalHeaderTitle(AppColor.text1)),
            Text(
              'Tạo danh sách công việc cho người làm',
              style: AppTextTheme.subText(AppColor.text3),
            )
          ],
        ),
        Transform.scale(
            scale: 1,
            child: Switch(
              onChanged: toggleSwitch,
              value: isSwitched,
              activeColor: AppColor.primary2,
              activeTrackColor: AppColor.secondary4,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color.fromRGBO(33, 33, 33, 0.08),
            ))
      ]),
    );
  }

  Widget payButton(
    String price,
    String name, {
    required void Function()? onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColor.shade9,
          padding: const EdgeInsets.all(16),
        ),
        onPressed: onPressed,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '$price VNĐ/ $name tiếng',
            style: AppTextTheme.headerTitle(AppColor.text2),
          ),
          Text(
            'TIẾP THEO',
            style: AppTextTheme.headerTitle(AppColor.text2),
          )
        ]),
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: 334,
              height: 316,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thêm công việc',
                      style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.shade1,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 52,
                      child: TextField(
                        controller: _addTask,
                        style: AppTextTheme.mediumBodyText(AppColor.text3),
                        cursorColor: AppColor.text3,
                        decoration: InputDecoration(
                          fillColor: AppColor.shade1,
                          filled: true,
                          disabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.text7, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.text7, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.text7, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 8,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    _buttonDialog(
                      AppColor.primary2,
                      () {
                        setState(() {
                          listTask.insert(0, _addTask.text);
                          _saveList(listTask);
                        });
                        _addTask.text = '';

                        Navigator.pop(context);
                      },
                      SvgIcon(
                        SvgIcons.add,
                        size: 24,
                        color: AppColor.text2,
                      ),
                      'Thêm',
                      AppColor.text2,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    _buttonDialog(
                      AppColor.shade1,
                      () {
                        Navigator.pop(context);
                      },
                      SvgIcon(
                        SvgIcons.close,
                        size: 24,
                        color: AppColor.text3,
                      ),
                      'Hủy bỏ',
                      AppColor.text3,
                    ),
                  ]),
            ),
          );
        });
  }

  Widget _buttonDialog(Color? backgroundColor, void Function()? onPressed,
      SvgIcon icon, String text, Color color) {
    return SizedBox(
      height: 52,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: AppTextTheme.headerTitle(color),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget inputProfile(
      {required String title,
      String? initialValue,
      void Function(String)? onChanged,
      void Function(String?)? onSaved,
      TextInputType? keyboardType,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextTheme.normalHeaderTitle(AppColor.text1),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            cursorColor: AppColor.text3,
            style: AppTextTheme.normalText(AppColor.text1),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: AppColor.text7, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: AppColor.text7, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: AppColor.primary1, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget saveButton({
    required void Function()? onPressed,
    required String name,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          backgroundColor: AppColor.primary2,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(
          name,
          style: AppTextTheme.headerTitle(AppColor.text2),
        ),
      ),
    );
  }

  _editUserInfo() {
    _userBloc.editProfile(editModel: _editUser).then(
      (value) async {
        AuthenticationBlocController().authenticationBloc.add(GetUserData());
        setState(() {
          _mainPageProfile = !_mainPageProfile;
        });
        JTToast.successToast(message: ScreenUtil.t(I18nKey.updateSuccess)!);
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

  void _fetchDataOnPage() {
    _taskBloc.fetchAllData(params: {});
    _serviceBloc.fetchAllData(params: {});
  }
}
