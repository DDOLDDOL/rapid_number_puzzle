# rapid_number_puzzle

<br>
<br>
<br>

## 🛠 기술 스택
### Frontend
Flutter (v3.32.5), Dart (v3.8.1)
  
### Backend
Firebase
- Auth
- Realtime Database
  
### State Management
BLoC
- https://pub.dev/packages/flutter_bloc

<br>
<br>
<br>

## 버전관리 전략
### TBD (Trunk-Based Development)
- main (Default 브랜치, Code-Freezing)
- feature/ (신규 피쳐 개발)
- refactor/ (기존 기능 보수)
- fix/ (버그 픽스)

<br>
<br>
<br>

## CI/CD
- 프로젝트 목적 및 시간 관계상 적용하지 않음

<br>
<br>
<br>

## ⚡️ How to Get Started (안드로이드는 릴리즈 키 해시가 없으므로 디버깅만 가능)
1. 프로젝트 clone / fork
2. just init (JustFile 커맨드)
3. flutter run

<br>
<br>
<br>

## 📁 파일 (도메인) 구조
### Feature First
- Feature: auth, number_puzzle, ...
- Role: bloc, screens, repository, widgets, ...
  
### 시각화
lib/  
├── feature1/  
│   ├── role1/  
│   └── role2/  
│   └── ...  
├── feature2/  
│   ├── role1/  
│   └── role2/  
│   └── ...  
└── main.dart

<br>
<br>
<br>

## 🚀 주요 기능
1. Firebase Auth (Google Oauth만, login & logout)
2. Firebase Realtime Database로 리더보드 구현
   전체 점수&랭킹
3. Number Puzzle Game 구현

<br>
<br>
<br>

## 🎯 Merge Note
### Merge#1 `feature/auth -> main`
- Google Sign In & Firebase Auth 구현
- 로딩/에러 분기 처리 및 상태 관리를 위해 AuthBloc 구현
- User Auth 전역 관리를 위해 AuthGuard 구현
- LoginScreen 구현 (Animation)
<br>

### Merge#2 `feature/number-puzzle -> main`
- Number Puzzle 및 기록 & 랭킹 리더보드 구현
- Firebase RTDB로 데이터 저장 및 불러오기
- Cubit으로 Save/Fetch 비동기 핸들링
- NumberPuzzleBoard 구현 (Cubit & Animation)
<br>

### Merge#3 `fix/logout -> main`
- 로그아웃 시 HomeMenuBottomSheet이 닫히지 않는 현상 수정