import 'package:intl/intl.dart';

extension GetHourDiferenceFromDate on DateTime {
  String get lastTime => () {
        var now = DateTime.now();
        if (now.difference(this).inMinutes < 60) {
          return "${now.difference(this).inMinutes}m";
        }
        if (now.difference(this).inHours < 24) {
          return "${now.difference(this).inHours}h";
        }
        return getDayOfWeek;
      }();

  String get getDateFormatted => DateFormat("dd/MM/yyyy").format(this);

  String get getDayOfWeek => () {
        String day = DateFormat("EEEE").format(this);

        switch (day) {
          case "Monday":
            return "Segunda-feira";
          case "Tuesday":
            return "Terça-feira";
          case "Wednesday":
            return "Quarta-feira";
          case "Thursday":
            return "Quinta-feira";
          case "Friday":
            return "Sexta-feira";
          case "Saturday":
            return "Sábado";
          case "Sunday":
            return "Domingo";
          default:
            return "";
        }
      }();
}

extension ConvertToDate on String {
  DateTime convertToDate() {
    var date = DateTime.parse(this);
    return date;
  }
}
