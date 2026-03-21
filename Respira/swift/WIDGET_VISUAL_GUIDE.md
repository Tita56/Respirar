# 🎨 Guía Visual de Widgets - Respira

## 📱 Widget de Estadísticas

### Small Widget (Pequeño)
```
┌─────────────────┐
│   🔥  Racha     │
│                 │
│       7         │
│                 │
│  días seguidos  │
│                 │
│  42 sesiones    │
└─────────────────┘
```
**Uso:** Pantalla de inicio, Hoy (Today View)

---

### Medium Widget (Mediano)
```
┌──────────────────────────────────┐
│  🔥 7      │    🟦 Box          │
│            │                     │
│  Racha     │    Favorito         │
│  actual    │    Box Breathing    │
│            │                     │
│  42 sesiones                     │
│  Hace 2h                         │
└──────────────────────────────────┘
```
**Uso:** Pantalla de inicio, Hoy (Today View)

---

### Large Widget (Grande)
```
┌──────────────────────────────────┐
│  💨 Respira                      │
│                                  │
│  ┌──────────┐  ┌──────────┐    │
│  │ 🔥  7    │  │ ✅  42   │    │
│  │ Racha    │  │ Sesiones │    │
│  └──────────┘  └──────────┘    │
│  ────────────────────────────   │
│                                  │
│  Tu patrón favorito              │
│  ┌────────────────────────────┐ │
│  │  🟦  Box Breathing         │ │
│  └────────────────────────────┘ │
│                                  │
│  Última práctica: Hace 2 horas   │
└──────────────────────────────────┘
```
**Uso:** Pantalla de inicio

---

## 🚀 Widget de Acceso Rápido

### Medium Quick Action
```
┌──────────────────────────────────┐
│   Respiración Rápida             │
│                                  │
│  ┌──────────┐  ┌──────────┐    │
│  │  🟦      │  │  🌙      │    │
│  │          │  │          │    │
│  │  Box     │  │  4-7-8   │    │
│  └──────────┘  └──────────┘    │
└──────────────────────────────────┘
```
**Características:**
- ✅ Botones interactivos (iOS 17+)
- ✅ Abre la app con el patrón seleccionado
- ✅ Inicia automáticamente la sesión

---

### Large Quick Action
```
┌──────────────────────────────────┐
│  💨 Acceso Rápido                │
│                                  │
│  🟦  Box Breathing          ▶   │
│  🌙  4-7-8 Relajante        ▶   │
│  ⬡   5-5-5 Equilibrio       ▶   │
│  ⚡  Respiración Energizante ▶   │
│  🍃  Calma Profunda         ▶   │
└──────────────────────────────────┘
```
**Características:**
- ✅ 5 patrones de respiración
- ✅ Toca cualquiera para iniciar
- ✅ Acceso ultra-rápido

---

## 🔒 Lock Screen Widgets (Pantalla Bloqueada)

### Circular
```
  ┌───────┐
  │  🔥   │
  │   7   │
  └───────┘
```

### Rectangular
```
┌────────────────────────┐
│ 🔥 7 días seguidos     │
│    42 sesiones         │
└────────────────────────┘
```

### Inline
```
🔥 7 días · 42 sesiones
```

**Ubicaciones:**
- ✅ Pantalla bloqueada (iOS 16+)
- ✅ StandBy Mode
- ✅ Apple Watch (complicaciones)

---

## 🎯 Flujo de Uso

### Escenario 1: Ver Progreso
```
Usuario → Agrega widget Small
         ↓
      Ve su racha de 7 días
         ↓
      Se motiva a continuar
```

### Escenario 2: Inicio Rápido
```
Usuario → Toca "Box Breathing" en widget
         ↓
      App se abre automáticamente
         ↓
      Sesión inicia en 0.5 segundos
         ↓
      Usuario respira sin fricción
```

### Escenario 3: Motivación Matutina
```
08:00 AM → Usuario ve widget en pantalla bloqueada
           ↓
        "🔥 6 días seguidos"
           ↓
        Toca widget de Acceso Rápido
           ↓
        Inicia sesión matutina
           ↓
        Racha se actualiza a 7 días
```

---

## 🎨 Paleta de Colores

Los widgets usan un degradado hermoso:

```swift
LinearGradient(
    gradient: Gradient(colors: [
        Color.blue.opacity(0.6),     // Azul suave
        Color.purple.opacity(0.4)    // Púrpura tenue
    ]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)
```

**Colores de íconos:**
- 🔥 Racha: `.orange` con degradado a `.yellow`
- ✅ Sesiones: `.green`
- 💨 App icon: `.white`

---

## 📊 Actualización de Datos

### Frecuencia de Actualización

**Widget de Estadísticas:**
- Se actualiza cada hora automáticamente
- Se actualiza inmediatamente al guardar una sesión
- Timeline policy: `.after(nextUpdate)`

**Widget de Acceso Rápido:**
- Contenido estático (botones)
- No necesita actualizaciones frecuentes
- Timeline policy: `.never`

### Trigger de Actualización Manual

```swift
// Después de guardar una sesión
WidgetCenter.shared.reloadAllTimelines()

// O recargar solo un tipo específico
WidgetCenter.shared.reloadTimelines(ofKind: "RespiraWidget")
```

---

## 🔧 Personalización Futura

### Ideas para Expandir

1. **Widget Configurable**
   - Permitir al usuario elegir qué estadística mostrar
   - Selector de patrón favorito manual

2. **Temas de Color**
   - Modo claro/oscuro automático
   - Tema personalizado por hora del día
   - Colores según el patrón de respiración

3. **Motivación Dinámica**
   - Mensajes motivacionales basados en racha
   - Recordatorios inteligentes
   - Celebración de logros

4. **Estadísticas Avanzadas**
   - Gráfico de tendencia de la semana
   - Comparación con semanas anteriores
   - Tiempo total respirado este mes

5. **Live Activities**
   - Mostrar sesión activa en Dynamic Island
   - Progreso de ciclos en tiempo real
   - Countdown visual de la fase actual

---

## 📱 Compatibilidad

| Widget Type | iOS 14 | iOS 16 | iOS 17 |
|------------|---------|---------|---------|
| Small/Medium/Large | ✅ | ✅ | ✅ |
| Lock Screen | ❌ | ✅ | ✅ |
| Interactive Buttons | ❌ | ❌ | ✅ |
| App Intents | ❌ | ❌ | ✅ |

**Recomendación:** 
- Versión mínima: iOS 16 (para Lock Screen widgets)
- Versión óptima: iOS 17+ (para botones interactivos)

---

## 🎓 Mejores Prácticas

### ✅ Hacer:
- Mantener el diseño simple y limpio
- Usar íconos SF Symbols consistentes
- Actualizar datos después de cada sesión
- Probar en todos los tamaños de widget
- Proporcionar placeholders realistas

### ❌ Evitar:
- Texto muy pequeño (ilegible)
- Demasiada información en widgets pequeños
- Actualizaciones muy frecuentes (consume batería)
- Animaciones complejas (no son soportadas)
- Depender de red para datos críticos

---

## 🐛 Debugging

### Ver logs del widget:
```bash
# En Xcode Console
log stream --predicate 'subsystem contains "RespiraWidget"'
```

### Verificar App Group:
```swift
print(AppGroup.containerURL)
// Debería mostrar: file:///Users/.../group.com.respira.shared/
```

### Forzar recarga:
```swift
// En la app
WidgetCenter.shared.reloadAllTimelines()

// O desde Terminal
xcrun simctl spawn booted log stream --predicate 'subsystem == "com.apple.chronod"'
```

---

¡Disfruta de tus widgets de Respira! 🎉

Si necesitas ayuda adicional, consulta `WIDGET_SETUP.md` para instrucciones de configuración.
