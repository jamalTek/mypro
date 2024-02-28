import '../controllers/notification_controller.dart';

Day getDayByTitle(String title) {
  return Day.values.firstWhere(
      (element) => element.name.toLowerCase() == title.toLowerCase());
}
