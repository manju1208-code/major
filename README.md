# Mahabharatam App — Full Setup Guide (Manjula కి)

Ee app లో ready గా unnavi:
- Login / Signup (Firebase Auth)
- Home (Characters + Parvas tabs), Search, Dark mode toggle
- Character/Parva detail screens (English + Telugu)
- Favorites (heart icon, saves to Firestore)
- Quiz (score save + Profile lo history)
- Admin Panel (characters/Parvas/quiz add-edit-delete) — only admin login కి కనిపిస్తుంది

Nీ pని ippudu: ఈ క్రింది steps follow చేసి, Firebase connect చేసి, run చేయాలి. Motham 15-20 nimishalu padutundi (chala fast, step by step follow cheయు).

## STEP 1: Firebase Project create cheయడం (5 min)
1. https://console.firebase.google.com ki వెళ్ళి Google login చేయి
2. "Add project" → పేరు పెట్టు (e.g. "mahabharatam-app") → Continue → Create project
3. Project open అయ్యాక, ఎడమవైపు **Build > Authentication** కి వెళ్ళి "Get Started" → **Email/Password** enable చేయి
4. ఎడమవైపు **Build > Firestore Database** కి వెళ్ళి "Create database" → **Start in test mode** select చేయి (college project కి సరిపోతుంది) → Enable

## STEP 2: Flutter project లో Firebase connect cheయడం (5 min)
Terminal (VS Code / Android Studio) లో ఈ project folder లోకి వెళ్ళి:

```
flutter pub get
dart pub global activate flutterfire_cli
flutterfire configure
```

`flutterfire configure` run చేసినప్పుడు:
- ఇది నీ Firebase account login అడుగుతుంది → అవును చేయి
- ఇప్పుడు create చేసిన project select చేయి (mahabharatam-app)
- Platforms: android, ios (లేదా web అవసరమైతే) select చేయి → Enter

ఇది automatic గా `lib/firebase_options.dart` file create చేస్తుంది.

## STEP 3: main.dart లో connect cheయడం
`lib/main.dart` file open చేసి, ఈ 2 లైన్లు add చేయి:

1. Top లో import add చేయి:
```dart
import 'firebase_options.dart';
```

2. `Firebase.initializeApp()` line ని ఇలా మార్చు:
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

## STEP 4: Run cheయడం
```
flutter run
```

## STEP 5: Admin account create cheయడం
1. App లో Sign Up చేయి email గా: **admin@mahabharatam.com** (ఏదైనా password)
2. ఈ email తోనే login అయితే, Admin Panel option కనిపిస్తుంది (top-right menu లో)
3. Admin Panel లో "cloud upload" icon తో sample Characters/Parvas add చేసుకోవచ్చు, "Load Sample Quiz Questions" button తో quiz కూడా add చేసుకోవచ్చు
4. ఆ తర్వాత + button తో నీ own 45+ characters, 18 Parvas content add చేసుకోవచ్చు

(Admin email మార్చుకోవాలంటే: `lib/services/auth_service.dart` file లో `isAdmin` line లో email మార్చు)

## Features Checklist
- [x] Login/Signup — Firebase Auth
- [x] Frontend — Characters, Parvas, Search, Dark mode
- [x] Backend — Firestore (characters, parvas, quiz_questions, quiz_results, favorites)
- [x] Quiz + Score tracking (Profile screen)
- [x] Favorites
- [x] Admin Panel (content management)

## Common Errors
- **"No Firebase App"** error → Step 2/3 సరిగ్గా చేయలేదు, flutterfire configure మళ్ళీ run చేయి
- **Firestore permission denied** → Firestore test mode లో create చేసావా చూడు (Step 1.4)
- **Package not found** → `flutter pub get` మళ్ళీ run చేయి
