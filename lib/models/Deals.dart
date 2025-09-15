class Deal {
  final int id;
  final String createdAt; 
  final int createdAtMillis;
  final String image;
  final int commentsCount;
  final String storeName;

  Deal({
    required this.id,
    required this.createdAt,
    required this.createdAtMillis,
    required this.image,
    required this.commentsCount,
    required this.storeName,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {

    String fullDate = json['created_at'] ?? "";
    String onlyDate =
        fullDate.contains("T") ? fullDate.split("T")[0] : fullDate;

    return Deal(
      id: json['id'] ?? 0,
      createdAt: onlyDate,
      createdAtMillis: json['created_at_in_millis'] ?? 0,
      image: json['image_medium'] ?? "",
      commentsCount: json['comments_count'] ?? 0,
      storeName: json['store']?['name'] ?? "Unknown Store",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "created_at": createdAt,
      "created_at_in_millis": createdAtMillis,
      "image_medium": image,
      "comments_count": commentsCount,
      "store": {"name": storeName},
    };
  }
}
