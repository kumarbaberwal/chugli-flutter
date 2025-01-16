import 'package:vibematch/features/chat/domain/entities/daily_question_entity.dart';

class DailyQuestionModel extends DailyQuestionEntity {
  DailyQuestionModel({required super.content});

  factory DailyQuestionModel.fromJson(Map<String, dynamic> json) {
    return DailyQuestionModel(
      content: json["question"] ?? "No question available",
    );
  }
}
