
import 'package:choira/models/questionmodel.dart';

class MusicQuestionBank {
  static List<MultipleChoiceQuestion> questions = [
    // Single correct answer
    MultipleChoiceQuestion(
      questionText: "Which instrument has 88 keys?",
      options: ["Guitar", "Piano", "Violin", "Drums"],
      correctAnswerIndexes: [1], // Only Piano
      allowMultipleSelection: false,
    ),
    
    MultipleChoiceQuestion(
      questionText: "What does 'forte' mean in music?",
      options: ["Soft", "Loud", "Fast", "Slow"],
      correctAnswerIndexes: [1], // Only Loud
      allowMultipleSelection: false,
    ),
    
    // Multiple correct answers
    MultipleChoiceQuestion(
      questionText: "Which of these are string instruments?",
      options: ["Guitar", "Piano", "Violin", "Drums", "Cello"],
      correctAnswerIndexes: [0, 2, 4], // Guitar, Violin, Cello
      allowMultipleSelection: true,
    ),
    
    MultipleChoiceQuestion(
      questionText: "Which music genres originated in America?",
      options: ["Jazz", "Classical", "Blues", "Rock", "Folk"],
      correctAnswerIndexes: [0, 2, 3], // Jazz, Blues, Rock
      allowMultipleSelection: true,
    ),
    
    MultipleChoiceQuestion(
      questionText: "Which composers were from the Romantic period?",
      options: ["Bach", "Chopin", "Mozart", "Liszt", "Beethoven"],
      correctAnswerIndexes: [1, 3], // Chopin, Liszt
      allowMultipleSelection: true,
    ),

    MultipleChoiceQuestion(
      questionText: "Which instruments are played with a bow?",
      options: ["Violin", "Guitar", "Cello", "Piano", "Viola", "Bass"],
      correctAnswerIndexes: [0, 2, 4, 5], // Violin, Cello, Viola, Bass
      allowMultipleSelection: true,
    ),

    MultipleChoiceQuestion(
      questionText: "What is the time signature of a waltz?",
      options: ["2/4", "3/4", "4/4", "6/8"],
      correctAnswerIndexes: [1], // 3/4
      allowMultipleSelection: false,
    ),

    MultipleChoiceQuestion(
      questionText: "Which of these are percussion instruments?",
      options: ["Drums", "Flute", "Tambourine", "Xylophone", "Trumpet"],
      correctAnswerIndexes: [0, 2, 3], // Drums, Tambourine, Xylophone
      allowMultipleSelection: true,
    ),
  ];

  // Get questions by type
  static List<MultipleChoiceQuestion> getSingleChoiceQuestions() {
    return questions.where((q) => !q.allowMultipleSelection).toList();
  }

  static List<MultipleChoiceQuestion> getMultipleChoiceQuestions() {
    return questions.where((q) => q.allowMultipleSelection).toList();
  }

  // Get random questions
  static List<MultipleChoiceQuestion> getRandomQuestions(int count) {
    List<MultipleChoiceQuestion> shuffled = List.from(questions);
    shuffled.shuffle();
    return shuffled.take(count).toList();
  }
}