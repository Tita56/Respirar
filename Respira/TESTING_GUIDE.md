# 🧪 Guía de Pruebas - Sistema de Historial

## 🚀 Paso 1: Compilar y Ejecutar

### En Xcode:
1. Abre el proyecto en Xcode
2. Selecciona un simulador (iPhone 15 Pro recomendado)
3. Presiona **Cmd + B** para compilar
4. Presiona **Cmd + R** para ejecutar

### Si hay errores de compilación:
- Verifica que el **Deployment Target** esté en **iOS 17.0+**
- Ve a Project Settings → General → Minimum Deployments

---

## 📱 Paso 2: Pruebas Manuales Básicas

### 🌬️ Test 1: Crear una Sesión
1. Inicia la app
2. Lee las instrucciones y presiona "Entendido"
3. Presiona "**Comenzar**"
4. Espera ~30 segundos
5. Presiona "**Detener**"
6. ✅ **Verifica:** Banner verde "Sesión guardada" aparece

### 📋 Test 2: Ver Historial
1. Ve al tab "**Historial**" (icono de reloj)
2. ✅ **Verifica:** Tu sesión aparece bajo "Hoy"
3. ✅ **Verifica:** Muestra el patrón, ciclos y duración
4. Desliza la sesión hacia la izquierda
5. ✅ **Verifica:** Aparece botón "Eliminar"
6. (No elimines aún)

### 📊 Test 3: Ver Estadísticas
1. Ve al tab "**Estadísticas**"
2. ✅ **Verifica:** Las 6 tarjetas muestran números
3. ✅ **Verifica:** Racha actual = 1 día
4. ✅ **Verifica:** Total sesiones = 1
5. ✅ **Verifica:** Aparece gráfica de "Minutos por Día"
6. Prueba cambiar el filtro (Semana → Mes → Año → Todo)
7. ✅ **Verifica:** Los datos se mantienen

### 🔁 Test 4: Múltiples Sesiones
1. Vuelve al tab "**Respirar**"
2. Toca el nombre del patrón actual
3. Selecciona un patrón diferente
4. Haz otra sesión (30 segundos)
5. Repite 2-3 veces más con diferentes patrones
6. Ve a "**Estadísticas**"
7. ✅ **Verifica:** Gráfica de "Patrones Más Usados" tiene múltiples barras
8. ✅ **Verifica:** Total sesiones incrementó

---

## 🧪 Paso 3: Modo Debug - Datos de Prueba

### Generar Datos Automáticamente
1. Ve al tab "**Debug**" (🐞 mariquita)
2. Lee cuántas sesiones hay actualmente
3. Presiona "**Generar Datos de Prueba**"
4. Espera la alerta "Completado"
5. Ve al tab "**Historial**"
6. ✅ **Verifica:** Múltiples sesiones de los últimos 14 días
7. Ve al tab "**Estadísticas**"
8. ✅ **Verifica:** Gráficas llenas de datos coloridos

### Probar con Datos Completos
1. En "**Estadísticas**", observa:
   - ✅ Racha actual debería ser ~14 días (si generaste datos)
   - ✅ Gráfica "Minutos por Día" con muchas barras
   - ✅ Gráfica "Patrones Más Usados" con colores diferentes
   - ✅ Gráfica "Ciclos Completados" con línea ondulada

2. Prueba los filtros:
   - **Semana**: Solo últimos 7 días
   - **Mes**: Últimos 30 días
   - **Año**: Todos (en este caso)
   - **Todo**: Todos los datos

### Limpiar Datos
1. En el tab "**Debug**"
2. Presiona "**Eliminar Todos los Datos**"
3. ✅ **Verifica:** Contador vuelve a 0
4. Ve al tab "**Historial**"
5. ✅ **Verifica:** Muestra mensaje "Sin sesiones aún"

---

## 🎯 Paso 4: Casos de Prueba Específicos

### Test de Racha
1. Elimina todos los datos (si hay)
2. Crea una sesión hoy
3. ✅ Racha actual = 1
4. En Debug, genera datos de prueba
5. ✅ Racha actual = 14 (aproximadamente)
6. Espera a mañana, crea otra sesión
7. ✅ Racha debería incrementar

### Test de Eliminación
1. Ve a "**Historial**"
2. Desliza una sesión
3. Presiona "Eliminar"
4. Confirma en el diálogo
5. ✅ **Verifica:** Sesión desaparece
6. Ve a "**Estadísticas**"
7. ✅ **Verifica:** Números se actualizaron

### Test de Persistencia
1. Crea 2-3 sesiones
2. **Cierra la app completamente** (swipe up en simulador)
3. Vuelve a abrir la app
4. ✅ **Verifica:** Todas las sesiones siguen ahí
5. Los datos persisten entre lanzamientos

### Test de Badges
1. Crea varias sesiones
2. Ve a diferentes tabs
3. ✅ **Verifica:** Tab "Historial" tiene badge con número de sesiones
4. ✅ **Verifica:** Tab "Estadísticas" tiene badge con racha actual (si > 0)

---

## 🐛 Problemas Comunes

### "No aparecen las sesiones"
- Verifica que presionaste "Detener" (no solo "Reset")
- Revisa que al menos completaste 1 ciclo
- Busca el banner "Sesión guardada"

### "Las gráficas no se ven"
- Necesitas al menos 2 sesiones para ver gráficas interesantes
- Usa el tab "Debug" para generar datos de prueba
- Verifica que el filtro de tiempo incluya tus sesiones

### "Error de compilación con Charts"
- Asegúrate de que iOS deployment target = 17.0+
- Swift Charts es nativo desde iOS 16

### "App crashea al abrir Estadísticas"
- Verifica que SwiftData está configurado en RespiraApp
- Comprueba que tienes import SwiftData en StatisticsView

---

## ✅ Checklist Final

Marca cuando hayas probado cada uno:

- [ ] Crear sesión básica
- [ ] Ver sesión en historial
- [ ] Ver estadísticas iniciales
- [ ] Crear múltiples sesiones con diferentes patrones
- [ ] Eliminar una sesión
- [ ] Generar datos de prueba (Debug)
- [ ] Verificar gráficas llenas
- [ ] Probar filtros de tiempo (Semana/Mes/Año/Todo)
- [ ] Cerrar y reabrir app (persistencia)
- [ ] Verificar badges en tabs
- [ ] Limpiar todos los datos
- [ ] Verificar estado vacío

---

## 🎉 Si Todo Funciona...

¡Felicidades! Tu sistema de historial está funcionando correctamente.

### Próximos pasos:
1. **Remover Debug Tab** antes de producción (ya está configurado con #if DEBUG)
2. **Añadir más features**: hápticos, widget, notificaciones
3. **Optimizar**: Añadir índices a SwiftData si tienes muchos datos
4. **Testing**: Crear tests unitarios para el cálculo de estadísticas

---

## 📝 Notas

- El tab "Debug" solo aparece en modo DEBUG
- En Release builds (App Store), solo verás los 3 tabs principales
- Los datos se guardan en el dispositivo/simulador
- Cada simulador tiene su propia base de datos independiente
