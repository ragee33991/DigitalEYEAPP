
class QuestionModel{

  String question;
  String answer;
  String option1;
  String option2;
  String option3;
  String option4;
  String option6;
  String option7;
  String option8;
  String correctOption;
  String id;
  String quizId;
  String quizWeekday;

  bool answered;

  QuestionModel({String question, String answer, String quizId}) {

    this.question = question;
    this.answer = answer;
    this.quizId = quizId;
  }




}