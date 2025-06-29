class  MultipleChoiceQuestion {
  final String questionText;
  final List<String> options;
  final List<int> correctAnswerIndexes;
  final bool allowMultipleSelection;

MultipleChoiceQuestion({
  required this.questionText,
  required this.options,
  required this.correctAnswerIndexes,
  this.allowMultipleSelection = true,
});

bool isCorrect(List<int> userAnswers) {
  if(userAnswers.length != correctAnswerIndexes.length) return false;

  List<int> sortedUser = List.from(userAnswers)..sort();
  List<int> sortedCorrect = List.from(correctAnswerIndexes)..sort();

  for(int i = 0; i<sortedUser.length;i++){
    if(sortedUser[i]!= sortedCorrect[i]) return false;
  }
  return true;
}

bool isPartiallyCorrect(List<int> userAnswers){
  if(!allowMultipleSelection) return false;
  return userAnswers.any((answer) => correctAnswerIndexes.contains(answer)) && !isCorrect(userAnswers);
}

}