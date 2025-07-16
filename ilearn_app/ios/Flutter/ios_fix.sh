#!/bin/bash

echo "🧹 Limpiando Flutter y Xcode..."
flutter clean
rm -rf ios/Pods ios/.symlinks ios/Flutter/Generated.xcconfig ios/Podfile.lock pubspec.lock .dart_tool build

echo "📦 Restaurando dependencias..."
flutter pub get

echo "📁 Instalando Pods de iOS..."
cd ios
pod install --repo-update
cd ..

echo "🚀 Intentando compilar para iPhone..."
flutter run -d "iPhone 15" -t lib/main_updated.dart
