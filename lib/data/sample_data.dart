import '../models/character.dart';
import '../models/parva.dart';
import '../models/quiz_question.dart';

// Sample seed data. Use the Admin Panel inside the app to add more
// characters / Parvas / quiz questions — they will save directly to Firestore.

final List<Character> sampleCharacters = [
  Character(
    id: 'krishna',
    nameEn: 'Krishna',
    nameTe: 'కృష్ణుడు',
    descriptionEn: 'Krishna is the eighth avatar of Vishnu, guide and charioteer of Arjuna, who delivered the Bhagavad Gita on the battlefield of Kurukshetra.',
    descriptionTe: 'కృష్ణుడు విష్ణువు యొక్క ఎనిమిదవ అవతారం, అర్జునుడి రథసారథి, కురుక్షేత్ర యుద్ధభూమిలో భగవద్గీతను బోధించాడు.',
    role: 'Divine Guide',
  ),
  Character(
    id: 'arjuna',
    nameEn: 'Arjuna',
    nameTe: 'అర్జునుడు',
    descriptionEn: 'Arjuna is the third Pandava, a peerless archer, and the central figure to whom Krishna narrates the Bhagavad Gita.',
    descriptionTe: 'అర్జునుడు మూడవ పాండవుడు, అసమాన విలుకాడు, కృష్ణుడు భగవద్గీతను ఎవరికి బోధించాడో ఆ ముఖ్య పాత్ర.',
    role: 'Hero',
  ),
  Character(
    id: 'duryodhana',
    nameEn: 'Duryodhana',
    nameTe: 'దుర్యోధనుడు',
    descriptionEn: 'Duryodhana is the eldest Kaurava prince, whose rivalry with the Pandavas over the throne of Hastinapura leads to the great war.',
    descriptionTe: 'దుర్యోధనుడు జ్యేష్ఠ కౌరవ రాకుమారుడు, హస్తినాపుర సింహాసనం కోసం పాండవులతో అతని వైరమే మహా యుద్ధానికి దారితీసింది.',
    role: 'Antagonist',
  ),
  Character(
    id: 'bhishma',
    nameEn: 'Bhishma',
    nameTe: 'భీష్ముడు',
    descriptionEn: 'Bhishma is the grand patriarch of the Kuru dynasty, bound by a vow of celibacy, and commander of the Kaurava army in the early days of the war.',
    descriptionTe: 'భీష్ముడు కురు వంశ మహా పితామహుడు, బ్రహ్మచర్య వ్రతం పాటించాడు, యుద్ధం తొలి రోజుల్లో కౌరవ సేనాధిపతి.',
    role: 'Elder',
  ),
  Character(
    id: 'draupadi',
    nameEn: 'Draupadi',
    nameTe: 'ద్రౌపది',
    descriptionEn: 'Draupadi is the common wife of the five Pandavas, born from fire, whose humiliation in the Kaurava court becomes a turning point of the epic.',
    descriptionTe: 'ద్రౌపది ఐదుగురు పాండవుల ఉమ్మడి భార్య, అగ్నికుండం నుండి జన్మించింది, కౌరవ సభలో ఆమెకు జరిగిన అవమానం మహాభారతంలో కీలక మలుపు.',
    role: 'Heroine',
  ),
];

final List<Parva> sampleParvas = [
  Parva(
    id: 'adi',
    number: 1,
    nameEn: 'Adi Parva',
    nameTe: 'ఆది పర్వం',
    descriptionEn: 'The book of beginnings, introducing the lineage of the Kuru dynasty and the birth of the main characters.',
    descriptionTe: 'ఆరంభాల పుస్తకం, కురు వంశ మూలాన్ని మరియు ముఖ్య పాత్రల జననాన్ని పరిచయం చేస్తుంది.',
  ),
  Parva(
    id: 'sabha',
    number: 2,
    nameEn: 'Sabha Parva',
    nameTe: 'సభా పర్వం',
    descriptionEn: 'The book of the assembly hall, describing the game of dice and the humiliation of Draupadi.',
    descriptionTe: 'సభా మందిర పుస్తకం, పాచికల ఆట మరియు ద్రౌపది అవమానాన్ని వివరిస్తుంది.',
  ),
  Parva(
    id: 'vana',
    number: 3,
    nameEn: 'Vana Parva',
    nameTe: 'వన పర్వం',
    descriptionEn: 'The book of the forest, covering the twelve years of exile of the Pandavas.',
    descriptionTe: 'అరణ్య పుస్తకం, పాండవుల పన్నెండేళ్ల వనవాసాన్ని కవర్ చేస్తుంది.',
  ),
];

final List<QuizQuestion> sampleQuizQuestions = [
  QuizQuestion(
    id: 'q1',
    question: 'Who delivered the Bhagavad Gita?',
    options: ['Krishna', 'Bhishma', 'Vyasa', 'Arjuna'],
    correctIndex: 0,
  ),
  QuizQuestion(
    id: 'q2',
    question: 'How many Pandava brothers were there?',
    options: ['3', '4', '5', '6'],
    correctIndex: 2,
  ),
  QuizQuestion(
    id: 'q3',
    question: 'Who was the eldest Kaurava prince?',
    options: ['Dushasana', 'Duryodhana', 'Karna', 'Shakuni'],
    correctIndex: 1,
  ),
];
