 

import 'package:flutter/material.dart';

class ControlTime {
  ControlTime(
      {required this.startDay,
      required this.deadLineDay,
      required this.startTime,
      required this.endTime});
  late DateTime startDay;
  late DateTime deadLineDay;
  late TimeOfDay startTime;
  late TimeOfDay endTime;

  //  startDay =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).day;

  // deadLineDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3).day;

  // TimeOfDay startTime = TimeOfDay.now();

  // TimeOfDay endTime =TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
// Todo Adding update to add to another month(start day in month deadLine in next month for example)
  calTime() {
    int startTimeH = startTime.hour;
    int starTimeM = startTime.minute;
    int endTimeH = endTime.hour;
    int endTimeM = endTime.minute;
    if (startDay.month == deadLineDay.month &&
        startDay.year == deadLineDay.year) {
      //same month

      if (deadLineDay == startDay) {
        //inSameDAy
        if (startTime.period.name == endTime.period.name) {
          //in same period am == am || pm == pm
          //get all minutes only
          int allMin = 60 - starTimeM + endTimeM;
          //git all hours only
          int allHour = (1 + startTimeH) - endTimeH;
          //if all Hour return with negative
          allHour = (allHour < 0) ? allHour * -1 : allHour;
          //convert all hours to minutes and add all minustes
          int fullTimeInM = allMin + (allHour * 60);
          return fullTimeInM;
        } else {
          //in different period pm == am || am == pm
          int allmin = 60 - starTimeM + endTimeM;
          int allHour = (12 - (1 + startTimeH)) + endTimeH;

          int fullTimeInM = allmin + (allHour * 60);
          return fullTimeInM;
        }
      } else {
        //Different Day
        int startDayFullTime = 0;
        int endDayFullTime = 0;
        int days = 0;
        int fullTime = 0;
        //--------startTime-------

        if (startTime.period.name == "am") {
          startDayFullTime = 0;
          //get all time to reach next day 00:00
          //startDayFullTime is all time in frist day
          //adding 12 hour to reach from am to pm in startday
          startDayFullTime =
              12 * 60 + (12 - (startTimeH + 1)) * 60 + (60 - starTimeM);
         
        } else if (startTime.period.name == "pm") {
          startDayFullTime = 0;
          //get startDayFullTime put pm without adding 12 hour
          startDayFullTime = (24 - (startTimeH + 1)) * 60 + (60 - starTimeM);

        
        }
        //--------endTime-------
        if (endTime.period.name == "am") {
          endDayFullTime = 0;
          //get all time to reach the deadLine day 00:00
          //endDayFullTime is all time in deadLine day

          endDayFullTime = endTimeH * 60 + endTimeM;
        
        } else if (startTime.period.name == "pm") {
          endDayFullTime = 0;
          //adding 12 hour to reach from pm to am in deadLine day
          endDayFullTime = endTimeH * 60 + endTimeM;
          
        }
        days = deadLineDay.day - startDay.day - 1;
        days = days * 24 * 60;
        fullTime = days + startDayFullTime + endDayFullTime;
        return fullTime;
      }

    } else {
       
      //Differant Month

      int startDayFullTime = 0;
      int endDayFullTime = 0;
      int fullTime = 0;

      //get Time from frist to move next Day in Minutes
      if (startTime.period.name == "am") {
        startDayFullTime = 0;
        //get all time to reach next day 00:00
        //startDayFullTime is all time in frist day
        //adding 12 hour to reach from am to pm in startday
        startDayFullTime =
            12 * 60 + (12 - (startTimeH + 1)) * 60 + (60 - starTimeM);
        debugPrint((12 - (startTimeH + 1)).toString());
        debugPrint(startTimeH.toString());
        debugPrint(starTimeM.toString());
        debugPrint("startDayFullTimeAm : $startDayFullTime");
      } else if (startTime.period.name == "pm") {
        startDayFullTime = 0;
        //get startDayFullTime put pm without adding 12 hour
        startDayFullTime = (24 - (startTimeH + 1)) * 60 + (60 - starTimeM);

        debugPrint("starTimeM : $starTimeM");
        debugPrint("startTimeH : $startTimeH");
     
      }

      //--------endTime-------
      //get time from deadLine to go to previous day in Minutes

      if (endTime.period.name == "am") {
        endDayFullTime = 0;
        //get all time to reach the deadLine day 00:00
        //endDayFullTime is all time in deadLine day

        endDayFullTime = endTimeH * 60 + endTimeM;
       
      } else if (startTime.period.name == "pm") {
        endDayFullTime = 0;
        //adding 12 hour to reach from pm to am in deadLine day
        endDayFullTime = endTimeH * 60 + endTimeM;
      
      }
      //calculate day between start and deadLine Day in Minutes
      int daysDiff = deadLineDay.difference(startDay).inDays;
    
      //calculate all minutes
      fullTime = daysDiff * 60 * 24 + startDayFullTime + endDayFullTime;
      return fullTime;
    }
  }
}
