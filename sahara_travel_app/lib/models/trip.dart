/// Represents a curated trip card displayed on the home screen.
class Trip {
  const Trip({
    required this.title,
    required this.location,
    required this.duration,
    required this.price,
    required this.image,
  });

  final String title;
  final String location;
  final String duration;
  final double price;
  final String image;
}
