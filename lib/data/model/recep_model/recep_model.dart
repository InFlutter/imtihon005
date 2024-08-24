class RecepModel {
  final String recepName;
  final String recepDescription;
  final List<String> recepProducts;
  final String image;
  final String uid;

  RecepModel({
    required this.recepName,
    required this.recepDescription,
    required this.recepProducts,
    required this.image,
    required this.uid,
  });

  factory RecepModel.fromJson(Map<String, dynamic> json) {
    return RecepModel(
      uid: json['uid'] as String? ?? '',
      recepName: json['recepName'] as String? ?? '',
      recepDescription: json['recepDescription'] as String? ?? '',
      recepProducts:
          (json['recepProducts'] as List?)?.cast<String>().toList() ?? [],
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'recepName': recepName,
        'recepDescription': recepDescription,
        'recepProducts': recepProducts,
        'image': image,
        'uid': uid,
      };
  Map<String, dynamic> toUpdateJson() => {
    'recepName': recepName,
    'recepDescription': recepDescription,
    'recepProducts': recepProducts,
    'image': image,
  };

  RecepModel copyWith({
    String? recepName,
    String? recepDescription,
    List<String>? recepProducts,
    String? image,
    String? uid,
  }) =>
      RecepModel(
        uid: uid ?? this.uid,
        recepName: recepName ?? this.recepName,
        recepDescription: recepDescription ?? this.recepDescription,
        recepProducts: recepProducts ?? this.recepProducts,
        image: image ?? this.image,
      );

  static RecepModel initialValue() => RecepModel(
        recepName: '',
        recepDescription: '',
        recepProducts: [],
        image: '',
        uid: '',
      );
}
