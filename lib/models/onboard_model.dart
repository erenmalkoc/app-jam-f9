class OnBoardModel {
  final String title;
  final String description;
  final String imageName;

  OnBoardModel(this.title,this.description,this.imageName);

  String get imageWithPath => 'assets/$imageName.png';


}
class OnBoardModels {

  static final List<OnBoardModel> onBoardItems = [
    OnBoardModel('Aradığın sorunun cevabını bul', '', 'welcome_one'),
    OnBoardModel('En doğru cevabı gör ve cevabı beğen', '', 'welcome_two'),


  ];
}