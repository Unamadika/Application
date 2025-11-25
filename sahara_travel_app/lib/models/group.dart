/// Represents an open travel group that users can join.
class TravelGroup {
  const TravelGroup({
    required this.name,
    required this.region,
    required this.dateRange,
    required this.membersJoined,
    required this.membersTotal,
    required this.price,
    required this.highlight,
    required this.status,
  });

  final String name;
  final String region;
  final String dateRange;
  final int membersJoined;
  final int membersTotal;
  final double price;
  final String highlight;
  final GroupStatus status;

  double get fillPercent => membersJoined / membersTotal;
  int get spotsTotal => membersTotal;
  int get spotsFilled => membersJoined;
  double get sharedPrice => price;
  double get savings => 120; // placeholder savings amount
}

enum GroupStatus { open, fillingFast, lastCall, departingSoon }
