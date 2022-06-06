class TaskModel {
  String id;
  String title;
  String postTime;
  String taskTime;
  String taskStatus;
  String datePost;
  String cost;
  String userName;
  bool isSuccess;

  TaskModel(
    this.id,
    this.title,
    this.postTime,
    this.taskTime,
    this.taskStatus,
    this.datePost,
    this.cost,
    this.userName,
    this.isSuccess,
  );
}
