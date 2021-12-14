import 'package:intl/intl.dart';

List monthList = [
  "Januari",
  "Februari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember",
];

List yearList = [
  "2010",
  "2011",
  "2012",
  "2013",
  "2014",
  "2015",
  "2016",
  "2017",
  "2018",
  "2019",
  "2020",
  "2021",
  "2022"
];

final DateTime now = DateTime.now();

final DateFormat dateFormat = DateFormat.MMMM('id-ID');

final DateFormat yearFormat = DateFormat.y();

String dropDownMonth = dateFormat.format(now);

String dropDownYear = yearFormat.format(now);
