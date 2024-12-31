import 'package:intl/intl.dart';

String formatPrice (double price) {
  return NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(price);
}