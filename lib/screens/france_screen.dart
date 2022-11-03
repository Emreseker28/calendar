import 'package:calendar/screens/spain_screen.dart';
import 'package:calendar/services/calendar.dart';
import 'package:calendar/utilities/constants.dart';
import 'package:flutter/material.dart';

class FranceScreen extends StatefulWidget {
  const FranceScreen({this.franceCalendar});
  final franceCalendar;

  @override
  State<FranceScreen> createState() => _FranceScreenState();
}

class _FranceScreenState extends State<FranceScreen> {
  CalendarModel calendar = CalendarModel();
  String holidayName = ''; //For null safety, empty string has assigned.
  String countryISO = 'FR'; //This screen is for France. Hence, 'FR'.
  int dropdownValue = 2022; //Default value for the dropdown button.
  int year = 0; //For null safety number 0 has assigned.
  int month = 0;
  int day = 0;
  //Lists to store holiday names and dates.
  var holidayList = [];
  var yearList = [];
  var monthList = [];
  var dayList = [];
  //Getting the years for dropdown items.
  var list = getList();

//When this method is called, it updates the UI with new values.
  void updateUI(dynamic calendarData) {
    setState(() {
      if (calendarData == null) {
        //If there is no information available, use default values.
        holidayName = 'Cannot get holiday information';
        year = 0;
        month = 0;
        day = 0;
        return;
      }
/*For loop to store oncoming datas in list.
* Upper limit assigned manually, because there was no information in the API
* that shows the total number of holidays.
*/
      for (int i = 0; i < 24; i++) {
        var holiday = calendarData['response']['holidays'][i]['name'];
        var yearToAdd =
            calendarData['response']['holidays'][i]['date']['datetime']['year'];
        var monthToAdd = calendarData['response']['holidays'][i]['date']
            ['datetime']['month'];
        var dayToAdd =
            calendarData['response']['holidays'][i]['date']['datetime']['day'];
        //Adding the decoded data to the lists.
        holidayList.add(holiday);
        yearList.add(yearToAdd);
        monthList.add(monthToAdd);
        dayList.add(dayToAdd);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget
        .franceCalendar); //Calls the updateUI() function when the screen gets initialized.
  }

//This methods gets called when user selects a different year.
  void updateYear(int selectedYear) async {
    var newCalendarData =
        await calendar.getCountryCalendar(countryISO, selectedYear);
    setState(() {
      updateUI(newCalendarData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Card(
        child: DropdownButton<int>(
          //Dropdown button.
          value: dropdownValue, //Default value is 2022.
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: kMessageTextStyle,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int? value) {
            setState(() {
              dropdownValue = value!;
              updateYear(
                  dropdownValue); //Call updateUI() function by passing the selected year.
            });
          },
          items: list.map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem(
              //Update the shown Dropdown button year.
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
      Column(
        children: List.generate(holidayList.length, (index) {
          //This List.generate creates widget holidayList.lenght times.
          return Container(
            child: Column(
              children: [
                Text(
                  'Holiday: ${holidayList[index]}, Date: ${dayList[index]}-${monthList[index]}-${yearList[index]}',
                  style: kMessageTextStyle,
                ),
                //To seperate holidays for better UX.
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          );
        }),
      ),
      //A button to go to the Spain screen.
      ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SpainScreen();
            }));
          },
          child: Text(
            'Spain',
            style: kButtonTextStyle,
          ))
    ]);
  }
}
