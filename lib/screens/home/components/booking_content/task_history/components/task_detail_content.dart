import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/task/task.dart';
import '../../../../../../core/user/user.dart';
import '../../../../../../main.dart';
import '../../../../../../widgets/task_widget/task_widget.dart';

class TaskDetailContent extends StatefulWidget {
  final TaskModel task;
  final UserModel user;
  final Function()? onChangeContent;
  const TaskDetailContent({
    Key? key,
    required this.task,
    required this.user,
    this.onChangeContent,
  }) : super(key: key);

  @override
  State<TaskDetailContent> createState() => _TaskDetailContentState();
}

class _TaskDetailContentState extends State<TaskDetailContent> {
  bool _isShowCheckList = false;
  final _taskBloc = TaskBloc();

  @override
  void initState() {
    JTToast.init(context);
    _isShowCheckList = widget.task.checkList.isNotEmpty;
    super.initState();
  }

  @override
  void dispose() {
    _taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  navigateTo(taskBookedRoute);
                },
              ),
              Center(
                child: Text(
                  'Chi tiết công việc',
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (widget.task.tasker.id.isNotEmpty) _profile(),
                _userProfile(),
                _detailTask(),
                _paymentField(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _profile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipOval(
                  child: widget.task.tasker.avatar.isNotEmpty
                      ? Image.network(
                          widget.task.tasker.avatar,
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
              const SizedBox(
                width: 16,
              ),
              InkWell(
                highlightColor: AppColor.white,
                splashColor: AppColor.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        widget.task.tasker.name,
                        style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Xem thêm',
                          style: AppTextTheme.mediumBodyText(AppColor.primary2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Transform.rotate(
                            angle: 180 * pi / 180,
                            child: SvgIcon(
                              SvgIcons.arrowBack,
                              color: AppColor.primary2,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: widget.onChangeContent,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: AppColor.shadow.withOpacity(0.16),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgIcon(
                      SvgIcons.star1,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        widget.task.tasker.totalRating.toString(),
                        style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.text2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow.withOpacity(0.16),
              blurRadius: 16,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Thông tin của bạn',
              style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            Text(
              'Địa chỉ không tên 1',
              style: AppTextTheme.normalText(AppColor.text1),
            ),
            const SizedBox(
              height: 12,
            ),
            _detailItem(
              icon: SvgIcons.epLocation,
              text: widget.user.address,
            ),
            const SizedBox(
              height: 12,
            ),
            _detailItem(
              icon: SvgIcons.viewDetails,
              text: widget.user.address,
            ),
            const SizedBox(
              height: 12,
            ),
            _detailItem(
              icon: SvgIcons.telephone1,
              text: widget.user.phoneNumber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem({
    required SvgIconData? icon,
    required String text,
  }) {
    return Row(
      children: [
        SvgIcon(
          icon,
          color: AppColor.shade5,
          size: 24,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: AppTextTheme.normalText(AppColor.text1),
        )
      ],
    );
  }

  Widget _detailTask() {
    final price =
        NumberFormat('#,##0 VND', 'vi').format(widget.task.totalPrice);
    final startTime = formatFromInt(
      displayedFormat: 'HH:mm',
      value: widget.task.startTime,
      context: context,
    );
    final endTime = formatFromInt(
      displayedFormat: '- HH:mm',
      value: widget.task.endTime,
      context: context,
    );
    final date = formatFromInt(
      displayedFormat: 'E, dd/MM/yyyy',
      value: widget.task.date,
      context: context,
    );
    final hadDone = widget.task.checkList
        .where(
          (e) => e.status == true,
        )
        .length;
    final double angle = _isShowCheckList ? 180 : 0;
    final optionType =
        getOptionType(widget.task.service.optionType).toLowerCase();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColor.text2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: AppColor.shadow.withOpacity(0.16),
              blurRadius: 16.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chi tiết công việc',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColor.shade1),
                  padding: const EdgeInsets.only(
                      top: 4, bottom: 4, right: 12, left: 12),
                  child: Text(
                    getStatusName(widget.task),
                    style: AppTextTheme.mediumBodyText(
                      colorStatus(
                        index: widget.task.status,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            _detailItem(
                icon: SvgIcons.accessTime,
                text:
                    '${widget.task.selectedOption.quantity} $optionType, $startTime $endTime'),
            const SizedBox(
              height: 10,
            ),
            _detailItem(
              icon: SvgIcons.calenderToday,
              text: date,
            ),
            const SizedBox(
              height: 10,
            ),
            _detailItem(
              icon: SvgIcons.dollar1,
              text: price,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            Text(
              'Ghi chú cho người giúp việc',
              style: AppTextTheme.mediumBodyText(AppColor.primary1),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColor.shade1,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.task.note,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Danh sách nhắc việc',
                  style: AppTextTheme.mediumBodyText(AppColor.primary1),
                ),
                Row(
                  children: [
                    Text(
                      '$hadDone/${widget.task.checkList.length}',
                      style: AppTextTheme.normalText(AppColor.text3),
                    ),
                    InkWell(
                      child: Transform.rotate(
                        angle: angle * pi / 180,
                        child: SvgIcon(
                          SvgIcons.expandMore,
                          color: AppColor.black,
                          size: 24,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _isShowCheckList = !_isShowCheckList;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            if (_isShowCheckList)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.shade1,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.task.checkList.length,
                    itemBuilder: (context, index) {
                      final checkItem = widget.task.checkList[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              checkItem.status
                                  ? SvgIcon(
                                      SvgIcons.checkBox,
                                      size: 24,
                                      color: AppColor.shade9,
                                    )
                                  : SvgIcon(
                                      SvgIcons.checkBoxOutlinedBlank,
                                      size: 24,
                                      color: AppColor.others1,
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  checkItem.name,
                                  style:
                                      AppTextTheme.normalText(AppColor.text1),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            if (widget.task.tasker.id.isNotEmpty && widget.task.status > 1)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Divider(
                      color: AppColor.shade1,
                      height: 1,
                    ),
                  ),
                  Text(
                    'Chụp hình thành quả',
                    style: AppTextTheme.mediumBodyText(AppColor.primary1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _listImage(title: 'Trước'),
                  ),
                  _listImage(title: 'Sau'),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _listImage({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextTheme.mediumBodyText(AppColor.text1),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 100,
          child: ListView(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentField() {
    final price =
        NumberFormat('#,##0 VND', 'vi').format(widget.task.totalPrice);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.text2,
            boxShadow: [
              BoxShadow(
                  color: AppColor.shadow.withOpacity(0.16),
                  blurRadius: 16,
                  blurStyle: BlurStyle.outer)
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hình thức thanh toán',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.primary1),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColor.shade1,
                height: 1,
              ),
            ),
            _detailItem(
              icon: SvgIcons.wallet1,
              text: 'MOMO, *******756',
            ),
            const SizedBox(
              height: 12,
            ),
            _detailItem(
              icon: SvgIcons.dollar1,
              text: price,
            ),
            const SizedBox(
              height: 12,
            ),
            _detailItem(
              icon: SvgIcons.tag1,
              text: 'JOYTECH07',
            ),
          ],
        ),
      ),
    );
  }
}
