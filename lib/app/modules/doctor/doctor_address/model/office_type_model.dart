class OfficeTypeModel {
  final String title;
  final String imageUrl;

  OfficeTypeModel({required this.title, required this.imageUrl});
}

List<OfficeTypeModel> officeTypeList = [
  OfficeTypeModel(title: "House", imageUrl: "assets/icons/house.svg"),
  OfficeTypeModel(title: "Building", imageUrl: "assets/icons/apartment.svg"),
  OfficeTypeModel(title: "Office", imageUrl: "assets/icons/office.svg"),
  OfficeTypeModel(title: "Others", imageUrl: "assets/icons/other.svg"),
];
