// selected Date , start time >> end time
// If Today - check if the time is greater than now().hour
// else - add all hours

List<int> getAvailableAppointments(
  DateTime selectedDate,
  String start,
  String end,
) {
  int startHour = int.parse(start);
  int endHour = int.parse(end);

  List<int> availableHours = [];

  for (int i = startHour; i < endHour; i++) {
    bool isToday =
        selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month &&
        selectedDate.day == DateTime.now().day;

    if (isToday) {
      // we are today
      if (i > DateTime.now().hour + 1) {
        availableHours.add(i);
      }
    } else {
      availableHours.add(i);
    }
  }

  return availableHours;
}
