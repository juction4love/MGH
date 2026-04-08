import 'package:intl/intl.dart';

class StringHelpers {
  // १. मूल्यलाई भाषा अनुसार ढाँचामा बदल्ने (रु. ५,००० वा Rs. 5,000)
  static String formatCurrency(double amount, {bool isNepali = true}) {
    final format = NumberFormat.currency(
      symbol: isNepali ? 'रु. ' : 'Rs. ',
      decimalDigits: 0,
      locale: isNepali ? 'ne_NP' : 'en_IN', // ne_NP ले नेपाली अंक (१२३) दिन्छ
    );
    return format.format(amount);
  }

  // २. मितिलाई भाषा अनुसार बदल्ने (जस्तै: March 7, 2026 वा २०२६ मार्च ७)
  static String formatDate(DateTime date, {bool isNepali = true}) {
    if (isNepali) {
      // नेपाली लोक्यालिटीमा मिति (Format: yyyy MMMM d)
      return DateFormat('yyyy MMMM d', 'ne').format(date);
    }
    return DateFormat.yMMMMd('en_US').format(date);
  }

  // ३. नेपाली मोबाइल नम्बर प्रमाणीकरण (९७, ९८ बाट सुरु हुने १० अंक)
  static bool isValidNepaliMobile(String mobile) {
    // Ncell: 980, 981, 982 | NTC: 984, 985, 986, 974, 975 | Smart: 961, 962
    final regExp = RegExp(r'^(98|97|96)\d{8}$');
    return regExp.hasMatch(mobile);
  }

  // ४. पहिलो अक्षर ठूलो बनाउने (Capitalize - अंग्रेजीको लागि मात्र)
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  // ५. अङ्कलाई नेपाली अङ्कमा बदल्ने (Helper for Custom Labels)
  static String toNepaliNumbers(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const nepali = ['०', '१', '२', '३', '४', '५', '६', '७', '८', '९'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], nepali[i]);
    }
    return input;
  }
}
