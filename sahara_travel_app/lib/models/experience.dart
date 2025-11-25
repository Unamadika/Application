/// Represents a curated Sahara experience highlighted in the UI.
class DesertExperience {
  const DesertExperience({
    required this.title,
    required this.duration,
    required this.groupSize,
    required this.pricePerPerson,
    required this.description,
  });

  final String title;
  final String duration;
  final String groupSize;
  final double pricePerPerson;
  final String description;
}
