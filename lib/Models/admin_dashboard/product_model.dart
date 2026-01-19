class ProductModel {
  final String id;
  final String name;
  final String description;
  final List<String> categories;
  final bool hasCoupon;
  final String? couponCode;
  final int returnDays;
  final int warrantyMonths;
  final List<String> imageUrls;
  final bool isAvailable;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categories,
    required this.hasCoupon,
    this.couponCode,
    required this.returnDays,
    required this.warrantyMonths,
    required this.imageUrls,
    required this.isAvailable,
  });

  ProductModel copyWith({
    String? name,
    String? description,
    List<String>? categories,
    bool? hasCoupon,
    String? couponCode,
    int? returnDays,
    int? warrantyMonths,
    List<String>? imageUrls,
    bool? isAvailable,
  }) {
    return ProductModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      hasCoupon: hasCoupon ?? this.hasCoupon,
      couponCode: couponCode ?? this.couponCode,
      returnDays: returnDays ?? this.returnDays,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      imageUrls: imageUrls ?? this.imageUrls,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
