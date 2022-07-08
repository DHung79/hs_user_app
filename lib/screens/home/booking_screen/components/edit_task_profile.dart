import 'package:flutter/material.dart';
import '/core/service/model/service_model.dart';
import '/main.dart';
import '/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/authentication/auth.dart';
import '../../../../core/service/bloc/service_bloc.dart';
import '../../../../core/task/model/task_model.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../theme/svg_constants.dart';
import '../../../layout_template/content_screen.dart';

final editTaskProfileKey = GlobalKey<_EditTaskProfileState>();

class EditTaskProfile extends StatefulWidget {
  const EditTaskProfile({Key? key}) : super(key: key);

  @override
  State<EditTaskProfile> createState() => _EditTaskProfileState();
}

class _EditTaskProfileState extends State<EditTaskProfile> {
  final PageState _pageState = PageState();
  final _serviceBloc = ServiceBloc();
  int valueWeek = 0;
  int value = 0;
  String note = '';
  int quantity = 0;
  String name = '';
  bool isSwitched = false;
  DateTime? timePick;
  int price = 0;
  DateTime? selectedDate = DateTime.now();
  List<ServiceModel>? listOptions;
  late EditTaskModel? editModel;
  final currentRoute = getCurrentRoute();
  TextEditingController noteForTasker = TextEditingController();
  List listTask = [];
  final TextEditingController _addTask = TextEditingController();

  DateTime today = DateTime.now();

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

  TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().day);
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        timePick = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          _time.hour,
          _time.minute,
        );
      });
    }
  }

  _saveList(list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList("key", list);

    return true;
  }

  _getSavedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("key") != null) {
      listTask = prefs.getStringList("key")!;
    }
  }

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
    _getSavedList();
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
            child: content(),
          );
        },
      ),
    );
  }

  Widget content() {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        elevation: 16,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        backgroundColor: Colors.white,
        leading: BackButton(
            color: AppColor.text1,
            onPressed: () {
              navigateTo(rebookTaskRoute);
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
                  // const SizedBox(
                  //   height: 12,
                  // ),
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
                                                  editModel!
                                                      .checkList[index].name,
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
                                  itemCount: editModel!.checkList.length,
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
                    listOptions![0].options[price].price.toString(),
                    listOptions![0].options[0].name.toString(),
                    onPressed: () {
                      if (timePick == null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Material Dialog'),
                                content: const Text('Hey! I am Coflutter!'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text('Close')),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('HelloWorld!'),
                                  )
                                ],
                              );
                            });
                      } else {
                        navigateTo(rebookTaskRoute);
                        quantity = listOptions![0].options[0].quantity;
                        name = listOptions![0].options[0].name;
                        note = listOptions![0].options[0].note;
                        date = selectedDate!.millisecondsSinceEpoch;
                        startTime = timePick!.millisecondsSinceEpoch;
                        noteTasker = noteForTasker.text;
                        listTaskForTasker = listTask;
                      }
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

  SingleChildScrollView listWeek() {
    final List<Widget> dates = [];
    List weeks = [
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
    ];

    for (int i = 0; i <= 6; i++) {
      int day = today.add(Duration(days: i)).day;
      int dayOfWeek = today.add(Duration(days: i)).weekday;
      switch (dayOfWeek) {
        case 1:
          {
            dates.add(pickTimeWork(day.toString(), weeks[0], i));
          }
          break;
        case 2:
          {
            dates.add(pickTimeWork(day.toString(), weeks[1], i));
          }
          break;
        case 3:
          {
            dates.add(pickTimeWork(day.toString(), weeks[2], i));
          }
          break;
        case 4:
          {
            dates.add(pickTimeWork(day.toString(), weeks[3], i));
          }
          break;
        case 5:
          {
            dates.add(pickTimeWork(day.toString(), weeks[4], i));
          }
          break;
        case 6:
          {
            dates.add(pickTimeWork(day.toString(), weeks[5], i));
          }
          break;
        case 7:
          {
            dates.add(pickTimeWork(day.toString(), weeks[6], i));
          }
          break;
        default:
          {}
          break;
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
        child: Row(children: dates),
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
                '${_time.hour} : ${_time.minute}',
                style: AppTextTheme.bigText(AppColor.text1),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget pickTimeWork(String title, String content, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            valueWeek = index;
            if (valueWeek == index) {
              selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day + index);
            }
          });
        },
        style: TextButton.styleFrom(
          backgroundColor:
              valueWeek == index ? AppColor.primary2 : AppColor.text2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: valueWeek == index
              ? const BorderSide(color: Colors.transparent, width: 1)
              : BorderSide(color: AppColor.primary2),
        ),
        child: SizedBox(
          width: 60,
          height: 80,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              title,
              style: valueWeek == index
                  ? AppTextTheme.mediumHeaderTitle(AppColor.text2)
                  : AppTextTheme.mediumHeaderTitle(AppColor.text1),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              content.toString(),
              style: valueWeek == index
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
    return InkWell(
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
        ));
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

  void _fetchDataOnPage() {
    _serviceBloc.fetchAllData(params: {});
  }
}
