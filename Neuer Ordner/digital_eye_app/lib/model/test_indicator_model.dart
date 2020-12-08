class TestIndicatorModel {
  final String image;
  final String title;
  String description;
  bool selected = false;

  TestIndicatorModel(
      {this.image, this.title, this.description = "", this.selected = false});
}
