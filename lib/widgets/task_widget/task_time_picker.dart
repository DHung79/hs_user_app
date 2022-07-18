import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/task/task.dart';
import '../../main.dart';

class TaskTimePicker extends StatefulWidget {
  final EditTaskModel editModel;
  final Function(DateTime) onChangeDate;
  final Function(DateTime) onChangeTime;

  const TaskTimePicker({
    Key? key,
    required this.editModel,
    required this.onChangeDate,
    required this.onChangeTime,
  }) : super(key: key);

  @override
  State<TaskTimePicker> createState() => _TaskTimePickerState();
}

class _TaskTimePickerState extends State<TaskTimePicker> {
  final _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final List<DateTime> listDayOfWeek = [
      for (int i = 0; i < 7; i++)
        DateTime(
          _now.add(Duration(days: i)).year,
          _now.add(Duration(days: i)).month,
          _now.add(Duration(days: i)).day,
          0,
          0,
          0,
        ),
    ];
    final startDate = DateTime.fromMillisecondsSinceEpoch(
      widget.editModel.date,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thời gian làm việc',
                style: AppTextTheme.mediumHeaderTitle(
                  AppColor.text1,
                ),
              ),
              Text(
                'tháng ${startDate.month}, ${startDate.year}',
                style: AppTextTheme.normalHeaderTitle(
                  AppColor.primary1,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: SizedBox(
            height: 90,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: listDayOfWeek.length,
              itemBuilder: (context, index) {
                final day = listDayOfWeek[index];
                return _datePickerItem(
                  date: day,
                  task: widget.editModel,
                  onPressed: () {
                    widget.onChangeDate(day);
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _pickStartTime(widget.editModel),
        ),
      ],
    );
  }

  Widget _datePickerItem({
    required DateTime date,
    required EditTaskModel task,
    required void Function()? onPressed,
  }) {
    final dayOfWeek = DateFormat('E').format(date);
    final isActive = task.date > _now.millisecondsSinceEpoch
        ? task.date == date.millisecondsSinceEpoch
        : _now.day == date.day;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isActive ? AppColor.primary2 : AppColor.text2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(
            color: isActive ? Colors.transparent : AppColor.primary2,
          ),
        ),
        child: SizedBox(
          width: 60,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.day.toString(),
                style: AppTextTheme.mediumHeaderTitle(
                  isActive ? AppColor.text2 : AppColor.text1,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                dayOfWeek,
                style: AppTextTheme.mediumHeaderTitle(
                  isActive ? AppColor.text2 : AppColor.text1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pickStartTime(EditTaskModel editTaskModel) {
    return StatefulBuilder(builder: (context, setState) {
      final startTimeData = editTaskModel.startTime.toInt();
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadow.withOpacity(0.24),
              blurStyle: BlurStyle.outer,
              blurRadius: 16,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 167),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ),
                onPressed: () async {
                  final startTimeIntData =
                      DateTime.fromMillisecondsSinceEpoch(startTimeData);
                  final initialTime = TimeOfDay(
                    hour: startTimeIntData.hour,
                    minute: startTimeIntData.minute,
                  );
                  final TimeOfDay? pickTime = await showTimePicker(
                    context: context,
                    initialTime: initialTime,
                  );
                  if (pickTime != null) {
                    final date = DateTime.fromMillisecondsSinceEpoch(
                      editTaskModel.date.toInt(),
                    );
                    final startTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      pickTime.hour,
                      pickTime.minute,
                    );
                    widget.onChangeTime(startTime);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 38),
                  child: Text(
                    formatFromInt(
                      value: startTimeData,
                      context: context,
                      displayedFormat: 'HH:mm',
                    ),
                    style: AppTextTheme.bigText(AppColor.text1),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
