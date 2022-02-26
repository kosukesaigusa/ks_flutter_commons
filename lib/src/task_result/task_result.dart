/// 成功したかどうかとメッセージをもつ汎用的な TaskResult
class TaskResult {
  TaskResult({
    required this.isSuccess,
    required this.message,
  });
  final bool isSuccess;
  final String message;
}
