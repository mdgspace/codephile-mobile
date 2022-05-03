class DateUtils {
  static int fistDayofMonth(int month, int year) {
    final date = DateTime(year, month);

    return date.weekday % 7;
  }

  static int totalDayInTriplet(int triplet, int year) {
    switch (triplet) {
      case 0:
        return 90 + (year % 4 == 0 ? 1 : 0);

      case 1:
        return 91;

      default:
        return 92;
    }
  }

  static DateTime getDateTime(int days, int triplet, int year) {
    final month = triplet * 3 + 1;
    final date = DateTime(year, month, days);

    return date;
  }
}
