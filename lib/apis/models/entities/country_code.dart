import 'package:copy_with_extension/copy_with_extension.dart';

part 'country_code.g.dart';

@CopyWith()
class CountryCode {
  const CountryCode({
    required this.name,
    required this.code,
    required this.dialCode,
  });

  factory CountryCode.fromMap(Map<String, dynamic> map) {
    return CountryCode(
      name: map['name'] as String? ?? 'India',
      code: map['code'] as String? ?? 'IN',
      dialCode: map['dial_code'] as String? ?? '+91',
    );
  }

  final String name;

  final String code;

  final String dialCode;

  @override
  String toString() =>
      ''' CountryCode: { name: $name, code: $code, dialCode: $dialCode } ''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryCode &&
        other.name == name &&
        other.code == code &&
        other.dialCode == dialCode;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ dialCode.hashCode;
}
