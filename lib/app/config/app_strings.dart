import 'package:flutter/material.dart';
// import 'package:jiffy/jiffy.dart';

class AppStrings {
  static const appName = 'Business Expert';
  static const supportTicket = 'Support Ticket';
  static const taskManager = 'Task Manager';
  static const nullString = '--';
  static const poweredBy = 'Powered by';
  static const noImage = 'No Image';
  static String kappVersionWithDate = "Beta v3.0.3  08-Apr-2024";
  //  ${Jiffy.parse(DateTime.now().toString()).format(pattern: 'dd-MMM-yyyy')} ";
  static const kStartDate = "2000-01-01";
  static const kEndDate = "2030-12-31 23:59:59";

  static const List<String> attendanceStatus = [
    'All',
    'Present',
    'Rest Day',
    'Absent',
    'Leave',
    'Short Leave',
    'Holiday',
  ];

  static const Map<String, dynamic> markAttendanceStatusIcons = {
    'Time Out': Icons.alarm_outlined,
    'Time In': Icons.timer,
    'Break Out': Icons.free_breakfast_outlined,
    'Break In': Icons.free_breakfast_outlined,
    'Lunch Out': Icons.free_breakfast_outlined,
    'Lunch In': Icons.free_breakfast_outlined,
    'Pray Out': Icons.access_time_rounded,
    'Pray In': Icons.access_time_rounded,
    'Leave Out': Icons.time_to_leave_outlined,
    'Leave In': Icons.time_to_leave_outlined,
  };

  // static List<String> months = [
  //   'Jan',
  //   'Feb',
  //   'Mar',
  //   'Apr',
  //   'May',
  //   'Jun',
  //   'Jul',
  //   'Aug',
  //   'Sep',
  //   'Oct',
  //   'Nov',
  //   'Dec',
  // ];

  static List<Map<String, String>> monthsMap = [
    {'name': 'Jan', 'num': '01'},
    {'name': 'Feb', 'num': '02'},
    {'name': 'Mar', 'num': '03'},
    {'name': 'Apr', 'num': '04'},
    {'name': 'May', 'num': '05'},
    {'name': 'Jun', 'num': '06'},
    {'name': 'Jul', 'num': '07'},
    {'name': 'Aug', 'num': '08'},
    {'name': 'Sep', 'num': '09'},
    {'name': 'Oct', 'num': '10'},
    {'name': 'Nov', 'num': '11'},
    {'name': 'Dec', 'num': '12'},
  ];
}
