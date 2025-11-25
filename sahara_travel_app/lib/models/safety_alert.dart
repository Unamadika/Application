/// Represents a safety alert item on the safety screen.
class SafetyAlert {
  const SafetyAlert({
    required this.title,
    required this.message,
    required this.type,
  });

  final String title;
  final String message;
  final SafetyAlertType type;
}

enum SafetyAlertType { weather, route, health, general }
