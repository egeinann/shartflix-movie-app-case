class Pagination {
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  Pagination({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["totalCount"],
        perPage: json["perPage"],
        maxPage: json["maxPage"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "perPage": perPage,
        "maxPage": maxPage,
        "currentPage": currentPage,
      };
}