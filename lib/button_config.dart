

class ButtonConfig {
  final String buttonColor;
  final double padding;
  final double elevation;
  final double border;

  ButtonConfig({
    required this.buttonColor,
    required this.padding,
    required this.elevation,
    required this.border,
  });

  factory ButtonConfig.fromJson(Map<String, dynamic> json) {
    return ButtonConfig(
      buttonColor: json['buttonColor'],
      padding: json['padding'],
      elevation: json['elevation'],
      border: json['border']
    );
  }
}


