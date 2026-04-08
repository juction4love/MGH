class Validators {
  /// नाम खाली हुनुहुँदैन र कम्तिमा ३ अक्षरको हुनुपर्छ
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'कृपया आफ्नो नाम लेख्नुहोस् (Please enter your name)';
    if (value.length < 3) return 'नाम अलि छोटो भयो (Name is too short)';
    return null;
  }

  /// नेपालको १० अङ्कको मोबाइल नम्बर चेक गर्ने लजिक
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'फोन नम्बर अनिवार्य छ (Phone number is required)';
    final regex = RegExp(r'^[0-9]{10}$');
    if (!regex.hasMatch(value)) return '१० अङ्कको सही फोन नम्बर हाल्नुहोस् (Enter a valid 10-digit number)';
    return null;
  }

  /// कुनै पनि क्षेत्र अनिवार्य बनाउन
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return fieldName != null 
        ? '$fieldName भर्नुहोस् (Please enter $fieldName)' 
        : 'यो क्षेत्र अनिवार्य छ (This field is required)';
    }
    return null;
  }
}
