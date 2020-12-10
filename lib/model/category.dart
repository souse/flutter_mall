class CategoryModel {
  String mallCategoryId;
  String mallCategoryName;
  String image;
  List<dynamic> bxMallSubDto;
  Null comments;

  CategoryModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.comments,
    this.image,
  });

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      comments: json['comments'],
      image: json['image'],
    );
  }
}

class CategoryListModel {
  List<CategoryModel> data;

  CategoryListModel(this.data);

  factory CategoryListModel.fromJson(List json) {
    return CategoryListModel(
      json.map((i) => CategoryModel.fromJson(i)).toList(),
    );
  }
}

class BxMallSubDto {
  String mallCategoryId;
  String mallSubId;
  String mallSubName;
  Null comments;
}
