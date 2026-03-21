# ✅ Checklist de Implementación de Widgets - Respira

## 📋 Configuración Inicial en Xcode

### Paso 1: Crear Widget Extension
- [ ] File > New > Target
- [ ] Seleccionar "Widget Extension"
- [ ] Nombre: `RespiraWidget`
- [ ] Marcar "Include Configuration Intent" (opcional)
- [ ] Activar el nuevo scheme

### Paso 2: Configurar App Groups
- [ ] Target **Respira** > Signing & Capabilities > + Capability > App Groups
- [ ] Añadir: `group.com.respira.shared`
- [ ] Target **RespiraWidget** > Signing & Capabilities > + Capability > App Groups
- [ ] Añadir: `group.com.respira.shared` (mismo identificador)

### Paso 3: Añadir Archivos Creados
- [ ] Copiar `AppGroup.swift` al proyecto
- [ ] Copiar `WidgetDataManager.swift` al proyecto
- [ ] Copiar `RespiraWidget.swift` al proyecto
- [ ] Copiar `RespiraQuickActionWidget.swift` al proyecto
- [ ] Copiar `RespiraWidgetBundle.swift` al proyecto

### Paso 4: Configurar Targets de Archivos
Marcar en AMBOS targets (Respira + RespiraWidget):
- [ ] `AppGroup.swift`
- [ ] `WidgetDataManager.swift`
- [ ] `BreathingSession.swift`
- [ ] `BreathingPattern.swift`

Marcar SOLO en RespiraWidget:
- [ ] `RespiraWidget.swift`
- [ ] `RespiraQuickActionWidget.swift`
- [ ] `RespiraWidgetBundle.swift`

### Paso 5: Actualizar Archivos Existentes
- [ ] Actualizar `RespiraApp.swift` con el nuevo ModelContainer compartido
- [ ] Actualizar `ContentView.swift` con:
  - [ ] Método `saveSession()` mejorado
  - [ ] Nuevo método `checkForWidgetAction()`
  - [ ] Modificador `.onAppear { checkForWidgetAction() }`

### Paso 6: Limpiar Archivos Generados por Xcode
- [ ] Eliminar archivo de ejemplo del widget (si Xcode lo creó)
- [ ] Verificar que solo `RespiraWidgetBundle.swift` tenga `@main`
- [ ] Eliminar `@main` de `RespiraWidget.swift` si existe

---

## 🧪 Verificación y Pruebas

### Compilación
- [ ] El proyecto compila sin errores
- [ ] El target Respira compila correctamente
- [ ] El target RespiraWidget compila correctamente
- [ ] No hay warnings sobre App Groups

### Pruebas en Simulador
- [ ] Ejecutar la app principal
- [ ] Hacer al menos una sesión de respiración
- [ ] Verificar que se guarde la sesión
- [ ] Añadir widget Small a la pantalla de inicio
- [ ] Verificar que muestra datos correctos
- [ ] Añadir widget Medium
- [ ] Añadir widget Large
- [ ] Añadir widget de Acceso Rápido (Medium)
- [ ] Añadir widget de Acceso Rápido (Large)

### Pruebas de Interactividad (iOS 17+)
- [ ] Tocar botón "Box Breathing" en widget
- [ ] Verificar que la app se abre
- [ ] Verificar que el patrón se selecciona automáticamente
- [ ] Verificar que la sesión inicia automáticamente
- [ ] Probar con otro patrón (ej: "4-7-8 Relajante")

### Pruebas de Lock Screen (iOS 16+)
- [ ] Añadir widget Circular a pantalla bloqueada
- [ ] Añadir widget Rectangular
- [ ] Añadir widget Inline
- [ ] Verificar que muestran datos actualizados

### Actualización de Datos
- [ ] Completar una sesión
- [ ] Verificar que el widget se actualiza automáticamente
- [ ] Verificar que la racha aumenta correctamente
- [ ] Verificar que el total de sesiones aumenta

---

## 🔍 Debugging

### Si el widget no muestra datos:
- [ ] Verificar que App Group está configurado en ambos targets
- [ ] Verificar que `AppGroup.identifier` es correcto
- [ ] Verificar que archivos compartidos están en ambos targets
- [ ] Imprimir `AppGroup.containerURL` en consola
- [ ] Verificar que `WidgetDataManager.shared.updateWidgetData()` se llama

### Si el widget no se actualiza:
- [ ] Verificar que `WidgetCenter.shared.reloadAllTimelines()` se llama
- [ ] Verificar que `saveSession()` actualiza los datos
- [ ] Forzar recarga manual desde la app
- [ ] Eliminar y volver a añadir el widget

### Si los botones no funcionan:
- [ ] Verificar que usas iOS 17 o superior
- [ ] Verificar que `StartBreathingIntent` está correctamente implementado
- [ ] Verificar que `checkForWidgetAction()` está en `.onAppear`
- [ ] Verificar logs en Xcode Console

### Si hay errores de compilación:
- [ ] Verificar que todos los archivos compartidos están en ambos targets
- [ ] Verificar que solo hay UN `@main` (en `RespiraWidgetBundle.swift`)
- [ ] Limpiar build folder (Shift + Cmd + K)
- [ ] Limpiar derived data
- [ ] Reiniciar Xcode

---

## 📦 Archivos del Proyecto

### Nuevos Archivos Creados
```
Respira/
├── AppGroup.swift                    ✅ (Ambos targets)
├── WidgetDataManager.swift           ✅ (Ambos targets)
│
RespiraWidget/
├── RespiraWidget.swift               ✅ (Solo widget)
├── RespiraQuickActionWidget.swift    ✅ (Solo widget)
└── RespiraWidgetBundle.swift         ✅ (Solo widget, con @main)
```

### Archivos Modificados
```
Respira/
├── RespiraApp.swift                  🔧 Actualizado
├── ContentView.swift                 🔧 Actualizado
├── BreathingSession.swift            ✅ (Añadir a ambos targets)
└── BreathingPattern.swift            ✅ (Añadir a ambos targets)
```

### Archivos de Documentación
```
Docs/
├── WIDGET_SETUP.md                   📖 Guía de configuración
└── WIDGET_VISUAL_GUIDE.md            🎨 Guía visual
```

---

## 🎯 Estado Final

Al completar todos los checkboxes, deberías tener:

✅ **2 Tipos de Widgets:**
1. Widget de Estadísticas (6 variantes)
2. Widget de Acceso Rápido (2 variantes)

✅ **Funcionalidades:**
- Mostrar racha actual
- Mostrar total de sesiones
- Mostrar patrón favorito
- Botones interactivos para iniciar sesiones
- Widgets de pantalla bloqueada
- Actualización automática de datos

✅ **Compatibilidad:**
- iOS 14+ (widgets básicos)
- iOS 16+ (Lock Screen)
- iOS 17+ (botones interactivos)

---

## 🚀 Próximos Pasos (Opcional)

### Mejoras Adicionales
- [ ] Implementar widget configurable
- [ ] Añadir temas de color
- [ ] Crear Live Activities para sesiones activas
- [ ] Añadir soporte para Apple Watch
- [ ] Implementar notificaciones de recordatorio
- [ ] Añadir gráficos de tendencia

### Optimizaciones
- [ ] Reducir tamaño de memoria del widget
- [ ] Optimizar frecuencia de actualización
- [ ] Implementar caché inteligente
- [ ] Mejorar performance de timeline

### Testing
- [ ] Escribir tests unitarios para WidgetDataManager
- [ ] Crear tests de UI para widgets
- [ ] Probar en dispositivos físicos
- [ ] Probar con diferentes rachas (0, 1, 7, 30+ días)

---

## 📱 Verificación Final

Antes de enviar a producción:

- [ ] Widgets funcionan en iPhone (varios tamaños)
- [ ] Widgets funcionan en iPad
- [ ] Lock Screen widgets funcionan correctamente
- [ ] Botones interactivos funcionan (iOS 17+)
- [ ] App se abre correctamente desde widget
- [ ] Datos se sincronizan correctamente
- [ ] No hay crashes
- [ ] No hay memory leaks
- [ ] Performance es aceptable
- [ ] Diseño se ve bien en modo claro y oscuro

---

## 🎉 ¡Completado!

Cuando todos los checkboxes estén marcados, ¡tus widgets de Respira estarán listos para usar!

**Tips finales:**
- Guarda esta checklist para futuras referencias
- Documenta cualquier personalización que hagas
- Mantén los widgets simples y enfocados
- Escucha feedback de usuarios sobre qué información es más útil

¡Éxito con tu app! 🌬️✨
