Last login: Fri Jun 27 13:04:32 on ttys002
(base) oaliaga@Oscars-Mac-mini-2 ilearn_app % touch reset_flutter.sh

(base) oaliaga@Oscars-Mac-mini-2 ilearn_app % nano reset_flutter.sh




















  UW PICO 5.09                 File: reset_flutter.sh                 Modified  

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

File Name to write : reset_flutter.sh                                           
^G Get Help  ^T  To Files                                                     
^C Cancel    TAB Complete                                                     
