#!/bin/bash

echo "🧹 Limpieza completa del proyecto Flutter..."

# 1. Eliminar archivos de build, cache y paquetes temporales
flutter clean
rm -rf .dart_tool .packages build

# 2. Obtener dependencias nuevamente
flutter pub get

# 3. Verificar dispositivos conectados
echo "📱 Dispositivos disponibles:"
flutter devices

# 4. Ejecutar la app en modo limpio
echo "🚀 Ejecutando la app desde cero..."
flutter run

echo "✅ Reset completo finalizado."

