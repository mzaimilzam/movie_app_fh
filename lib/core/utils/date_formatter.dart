import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'N/A';
    }
    
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return 'N/A';
    }
  }
  
  static String formatYear(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return '';
    }
    
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy').format(date);
    } catch (e) {
      return '';
    }
  }
}
