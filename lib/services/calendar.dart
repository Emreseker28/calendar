import 'networking.dart';
import 'package:calendar/utilities/constants.dart';

class CalendarModel {
  Future<dynamic> getCountryCalendar(
      String countryName, int requestedYear) async {
    //Calling NetworkHelper class to get the information.
    NetworkHelper networkHelper = NetworkHelper(
        '$calendarificURL?&api_key=$apiKey&country=$countryName&year=$requestedYear');
    var calendarData = await networkHelper.getData();
    return calendarData;
  }
}
