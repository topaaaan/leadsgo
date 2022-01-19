import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

const kpPurple = Color(0xFF6F35A5);
//Color(0xFF2196F3);
// const kPrimaryColor = Color(0xFF5B5EA6);

const leadsGoColor = Color.fromRGBO(239, 124, 27, 1.0);
const deepleadsGoColor = Color.fromRGBO(215, 105, 15, 1.0);
const lightleadsGoColor = Color.fromRGBO(242, 143, 55, 1.0); //leadsGo BETA
const kPrimaryColor = Color.fromRGBO(93, 155, 44, 1.0);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const Color green200 = Color(0xFF1B5E20);
const Color green = Color.fromRGBO(0, 177, 106, 1);
const Color grey = Color.fromARGB(255, 242, 242, 242);
const Color grey200 = Color.fromARGB(200, 242, 242, 242);
const Color menuRide = Color(0xffe99e1e);
const Color menuCar = Color(0xff14639e);
const Color insentifCard = Color(0xff004D40);
const Color menuBluebird = Color(0xff2da5d9);
const Color menuFood = Color(0xffec1d27);
const Color menuSend = Color(0xff8dc53e);
const Color menuDeals = Color(0xfff43f24);
const Color menuPulsa = Color(0xff72d2a2);
const Color menuOther = Color(0xffa6a6a6);
const Color menuShop = Color(0xff0b945e);
const Color menuMart = Color(0xff68a9e3);
const Color menuTix = Color(0xffe86f16);

//default font
const fontFamily = TextStyle(fontFamily: 'LeadsGo-Font');

// String dayText = DateFormat.EEEE().format(DateTime.now());
// String hariIni = namaHari(dayText);

String hari = DateFormat.EEEE().format(DateTime.now());

namaHari(String hari) {
  switch (hari) {
    case 'Monday':
      return 'Senin';
      break;
    case 'Tuesday':
      return 'Selasa';
      break;
    case 'Wednesday':
      return 'Rabu';
      break;
    case 'Thursday':
      return 'Kamis';
      break;
    case 'Friday':
      return 'Jumat';
      break;
    case 'Saturday':
      return 'Sabtu';
      break;
    case 'Sunday':
      return 'Minggu';
      break;
  }
}

var date = DateTime.now();
String bulan = namaBulan(date.month.toString());
String bulanDepan = namaBulan((date.month + 1).toString());
String tahun = date.year.toString();

namaBulan(String bulan) {
  switch (bulan) {
    case '1':
      return 'Januari';
      break;
    case '2':
      return 'Februari';
      break;
    case '3':
      return 'Maret';
      break;
    case '4':
      return 'April';
      break;
    case '5':
      return 'Mei';
      break;
    case '6':
      return 'Juni';
      break;
    case '7':
      return 'Juli';
      break;
    case '8':
      return 'Agustus';
      break;
    case '9':
      return 'September';
      break;
    case '10':
      return 'Oktober';
      break;
    case '11':
      return 'November';
      break;
    case '12':
      return 'Desember';
      break;
    case '13':
      return 'Januari';
      break;
  }
}
