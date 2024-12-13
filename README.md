# Emeka's Leaderboard App

## Overview
Dynamic Flutter leaderboard app with real-time score updates and a sleek, minimalist design.

## Key Features
- 1-second splash screen
- Periodic score updates
- Automatic participant reordering
- Top participant highlight
- **New**: Leaderboard reset functionality

## Design Decisions

### UI/UX
- Gradient black-to-purple background for visual depth
- Minimalist black and white color scheme
- Ranking-based color coding:
  - Top 3 participants highlighted with distinct colors
  - Score colors indicate ranking prominence

### Technical Implementation
- State management via `setState()`
- Periodic timer for automatic score updates
- Dynamic sorting of participants
- Deep copy mechanism for leaderboard reset

## Quick Setup
```bash
flutter pub get
flutter run
```

## Usage
- App auto-updates scores every 2 seconds
- Tap refresh icon to reset leaderboard to initial state

## Requirements
- Flutter SDK
- Dart SDK

## VIDEO OF APP

https://github.com/user-attachments/assets/dd1d380f-58cf-4862-bb70-9ccbb61bfba2


