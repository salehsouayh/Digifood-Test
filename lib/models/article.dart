class Article {
  String? id;
  String? title;
  int? price;
  int? rating;
  String? shortDescription;
  String? longDescription;
  int? review;
  String? imgUrl;
  String? category;
  late int qty;

  Article({
    this.id,
    this.title,
    this.price,
    this.rating,
    this.shortDescription,
    this.longDescription,
    this.review,
    this.imgUrl,
    this.category,
    required this.qty,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    rating = json['rating'];
    shortDescription = json['shortDescription'];
    longDescription = json['longDescription'];
    review = json['review'];
    imgUrl = json['imgUrl'];
    category = json['category'];
    qty = 1;
  }

  Article copyWith({
    String? id,
    String? imgUrl,
    String? title,
    int? price,
    String? shortDescription,
    String? longDescription,
    int? review,
    int? rating,
    int? qty,
    String? category,
  }) {
    return Article(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      title: title ?? this.title,
      price: price ?? this.price,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      qty: qty ?? this.qty,
      category: category ?? this.category,
    );
  }
}
