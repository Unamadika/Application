/// Represents a nearby or featured guide in the Sahara app.
class Guide {
  const Guide({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
    required this.avatar,
  });

  final String name;
  final String role;
  final double rating;
  final int reviewCount;
  final String avatar;

  String get ratingLabel => rating.toStringAsFixed(1);
}
