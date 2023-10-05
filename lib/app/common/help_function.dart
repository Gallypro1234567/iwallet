import 'package:flutter/material.dart';

looseFocus(BuildContext context) {
  final FocusScopeNode currentScope = FocusScope.of(context);
  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

removeFocus(BuildContext context) {
  final FocusScopeNode currentScope = FocusScope.of(context);
  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

String thousandSeparator(
  dynamic rawInput, {
  bool keepDot = false,
  bool refine = false,
  bool point = false,
  String? unit,
}) {
  if (rawInput == null) {
    return '0';
  }
  num input;
  if (rawInput is String) {
    input = num.parse(rawInput);
  } else {
    input = rawInput;
  }
  if (input >= 9000000000000000000) {
    return 'Number too big';
  }
  var parts = input.toStringAsFixed(2).split('.');
  parts[0] = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.');
  String res = '';

  if (keepDot) {
    res = parts.join(',');
  } else {
    res = parts[0];
  }

  if (refine) {
    var obj = res.split(',');
    final e = res.split('.').length;
    switch (e) {
      case 2:
        if (!point) {
          double result = int.parse(obj[0].replaceAll('.', '')) / 1000.0;
          res = '${removeTrailingZeros(result)} Nghìn';
        } else {
          res;
        }
        break;
      case 3:
        double result = int.parse(obj[0].replaceAll('.', '')) / 1000000.0;
        res = '${removeTrailingZeros(result)} Triệu';
        break;
      case 4:
        double result = int.parse(obj[0].replaceAll('.', '')) / 1000000000.0;
        res = '${removeTrailingZeros(result)} Tỷ';
        break;
      case 5:
        double result = int.parse(obj[0].replaceAll('.', '')) / 1000000000000.0;
        res = '${removeTrailingZeros(result)} Nghìn Tỷ';
        break;
      default:
        break;
    }
  }

  if (unit != null) {
    unit = (' ') + unit;
  }
  return res + (unit ?? '');
}

String removeTrailingZeros(double number) {
  String formatted = number.toString();
  formatted = formatted.replaceAll(RegExp(r"(\.0*)(?=\D|$)"), "");
  return formatted;
}

List<String> dayNames = [
  'Chủ Nhật',
  'Thứ Hai',
  'Thứ Ba',
  'Thứ Tư',
  'Thứ Năm',
  'Thứ Sáu',
  'Thứ Bảy',
];
List<String> monthNames = [
  'Tháng 1',
  'Tháng 2',
  'Tháng 3',
  'Tháng 4',
  'Tháng 5',
  'Tháng 6',
  'Tháng 7',
  'Tháng 8',
  'Tháng 9',
  'Tháng 10',
  'Tháng 11',
  'Tháng 12'
];
String getDateTime(DateTime date) {
  // Format the DateTime object using custom names
  String formattedDate =
      '${dayNames[date.weekday]}, ${date.day.toString().padLeft(2, '0')} ${monthNames[date.month - 1]} ${date.year}';
  return formattedDate;
}

Map<String, dynamic> getTime(DateTime date) {
  return {
    'day_name': dayNames[date.weekday],
    'date': date.day.toString().padLeft(2, '0'),
    'month_name': monthNames[date.month - 1],
    'month': date.month,
    'year': date.year,
  };
}

class Result<T> {
  Result({this.httpMessage, this.result, this.header});
  final T? result;
  bool get success => result != null;
  final dynamic httpMessage;
  final Map<String, dynamic>? header;
  String get message {
    try {
      if (httpMessage is List) {
        return httpMessage.first;
      }
      return httpMessage ?? (result != null ? '' : 'Unknown error');
    } catch (e) {
      return httpMessage.toString();
    }
  }
}
