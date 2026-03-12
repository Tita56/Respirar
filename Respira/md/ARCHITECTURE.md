# 📱 Respira - Arquitectura de la App

```
RespiraApp
    │
    ├── 📊 SwiftData Model Container
    │   └── BreathingSession.self
    │
    └── 🎯 MainTabView (o MainTabViewDebug en DEBUG)
            │
            ├── Tab 1: 🌬️ Respirar (ContentView)
            │   ├── Animación de círculo
            │   ├── Selector de patrones
            │   ├── Controles de sonido
            │   ├── Botones Comenzar/Detener/Reset
            │   └── 💾 Guarda sesión al detener
            │
            ├── Tab 2: 🕐 Historial (HistoryView)
            │   ├── Lista agrupada por días
            │   ├── Sesiones con detalles
            │   ├── Swipe para eliminar
            │   └── 🔗 Link a Estadísticas
            │
            ├── Tab 3: 📊 Estadísticas (StatisticsView)
            │   ├── 6 Tarjetas de stats
            │   ├── 3 Gráficas (Swift Charts)
            │   └── Filtros de tiempo
            │
            └── Tab 4: 🐞 Debug (TestDataView) [Solo DEBUG]
                ├── Generar datos de prueba
                └── Eliminar todos los datos
```

## 🗂️ Estructura de Archivos

### 📱 Core App
```
RespiraApp.swift                  // Entry point + SwiftData config
MainTabView.swift                 // Navegación principal
MainTabView+Debug.swift           // Versión con tab de debug
```

### 🎨 Views
```
ContentView.swift                 // Vista principal de respiración
PatternSelectionView.swift        // Selector de patrones
SoundPresetSelectionView.swift    // Selector de presets de sonido
HistoryView.swift                 // Vista de historial
StatisticsView.swift              // Vista de estadísticas + gráficas
TestDataView.swift                // Vista de debug/testing
```

### 🗄️ Models
```
BreathingPattern.swift            // Modelo de patrones de respiración
BreathingSession.swift            // Modelo SwiftData de sesiones
SoundPreset.swift                 // Modelo de presets de sonido
```

### 🔊 Managers
```
SoundManager.swift                // Gestión de audio
HapticManager.swift               // Gestión de feedback háptico
```

### 🛠️ Utilities
```
PreviewHelper.swift               // Helpers para SwiftUI previews
```

### 📚 Documentation
```
README.md                         // Documentación principal
HISTORIAL_IMPLEMENTATION.md       // Detalles de implementación
TESTING_GUIDE.md                  // Guía de pruebas
ARCHITECTURE.md                   // Este archivo
```

## 📊 Flujo de Datos

### Guardado de Sesión
```
Usuario presiona "Comenzar"
    ↓
sessionStartTime = Date()
    ↓
Usuario hace ejercicio de respiración
    ↓
Usuario presiona "Detener"
    ↓
saveSession() calcula duración
    ↓
Crea BreathingSession
    ↓
modelContext.insert(session)
    ↓
modelContext.save()
    ↓
Banner "Sesión guardada" ✅
```

### Consulta de Datos
```
SwiftData @Query
    ↓
Observa automáticamente cambios
    ↓
HistoryView se actualiza ← sessions
    ↓
StatisticsView se actualiza ← sessions
    ↓
MainTabView badges se actualizan ← sessions
```

### Cálculo de Estadísticas
```
[BreathingSession] array
    ↓
BreathingSession.calculateStats(from:)
    ↓
SessionStats
    ├── totalSessions: Int
    ├── totalMinutes: Double
    ├── totalCycles: Int
    ├── averageDuration: Double
    ├── currentStreak: Int
    ├── longestStreak: Int
    └── favoritePattern: String?
```

## 🎯 Patrones de Diseño Utilizados

### 1. MVVM (Model-View-ViewModel)
- **Models**: BreathingSession, BreathingPattern, SoundPreset
- **Views**: ContentView, HistoryView, StatisticsView
- **ViewModels**: Implícito con @State, @Query, @Observable

### 2. Repository Pattern
- SwiftData actúa como repository
- @Query hace queries declarativas
- modelContext maneja persistencia

### 3. Observer Pattern
- @Query observa cambios en SwiftData
- @Observable para SoundManager
- SwiftUI re-renderiza automáticamente

### 4. Strategy Pattern
- Diferentes patrones de respiración
- Diferentes presets de sonido
- Configurables y extensibles

## 🔄 Estados de la App

### ContentView States
```swift
@State private var isBreathingIn: Bool           // Animación de expansión
@State private var isActive: Bool                // Sesión activa
@State private var currentPhaseIndex: Int        // Fase actual (inhale/hold/exhale/pause)
@State private var cycleCount: Int               // Ciclos completados
@State private var showInstructions: Bool        // Modal de bienvenida
@State private var showPatternSelection: Bool    // Sheet de patrones
@State private var showSoundPresetSelection: Bool // Sheet de sonidos
@State private var selectedPattern               // Patrón seleccionado
@State private var soundManager                  // Manager de sonido
@State private var sessionStartTime: Date?       // Timestamp de inicio
@State private var showSessionSaved: Bool        // Banner de confirmación
```

### Computed Properties
```swift
currentPhase: BreathPhase                        // Fase actual del patrón
```

## 🎨 Componentes Reutilizables

### En StatisticsView
```swift
StatCard(icon:iconColor:title:value:subtitle:)   // Tarjeta de estadística
```

### En ContentView
```swift
SessionSavedBanner()                              // Banner de confirmación
```

### En PatternSelectionView
```swift
PatternCard(pattern:isSelected:action:)           // Card de patrón
```

### En SoundPresetSelectionView
```swift
PresetRow(preset:isSelected:)                     // Row de preset
```

### En HistoryView
```swift
SessionRow(session:)                              // Row de sesión
```

## 📈 Performance

### Optimizaciones Implementadas
1. **@Query**: Queries eficientes con SwiftData
2. **Lazy Loading**: LazyVGrid en estadísticas
3. **Computed Properties**: Cálculos solo cuando cambian datos
4. **Animaciones**: Uso eficiente de withAnimation
5. **Preview Memory**: inMemory containers para previews

### Consideraciones Futuras
- Índices en SwiftData para queries grandes
- Paginación en historial si hay >100 sesiones
- Cache de gráficas calculadas
- Background thread para estadísticas pesadas

## 🧪 Testing

### Unit Tests (Sugeridos)
```
BreathingSessionTests
    ├── testSessionCreation()
    ├── testDurationCalculation()
    ├── testStreakCalculation()
    ├── testStatisticsCalculation()
    └── testFormattedProperties()

BreathingPatternTests
    ├── testPatternValidation()
    └── testPhaseSequence()
```

### UI Tests (Sugeridos)
```
RespiraUITests
    ├── testCompleteBreathingSession()
    ├── testViewHistoryAfterSession()
    ├── testDeleteSession()
    ├── testPatternSelection()
    └── testStatisticsDisplay()
```

## 🚀 Deployment

### Antes de Release
1. ✅ Remover tab Debug (ya configurado con #if DEBUG)
2. ⚠️ Verificar deployment target (iOS 17.0+)
3. ⚠️ Revisar permisos en Info.plist
4. ⚠️ Añadir Privacy Policy (si se exportan datos)
5. ⚠️ App Store screenshots y descripción
6. ⚠️ Testing en dispositivos reales

### Configuración de SwiftData
```swift
// Ya configurado en RespiraApp.swift
.modelContainer(for: BreathingSession.self)
```

### CloudKit (Futuro)
Para sincronización entre dispositivos:
```swift
.modelContainer(
    for: BreathingSession.self,
    isCloudSyncEnabled: true
)
```

## 🔐 Privacidad

### Datos Guardados Localmente
- Sesiones de respiración (fecha, duración, patrón)
- Preferencias de sonido
- No se recopila información personal
- No hay analytics externos
- Todo permanece en el dispositivo

### Para App Store
Declarar:
- No recopilamos datos
- No hay tracking
- Datos locales no compartidos

## 📱 Compatibilidad

### Requisitos
- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

### Frameworks Usados
- SwiftUI (UI)
- SwiftData (Persistencia)
- Swift Charts (Gráficas)
- AVFoundation (Audio)
- Foundation (Core)

## 🎉 Features Implementadas

- ✅ 5 Patrones de respiración
- ✅ Animaciones fluidas
- ✅ Sistema de sonido procedural
- ✅ 5 Presets de sonido
- ✅ Feedback háptico completo
- ✅ Guardado automático de sesiones
- ✅ Historial completo
- ✅ Estadísticas detalladas
- ✅ Gráficas interactivas
- ✅ Cálculo de rachas
- ✅ Navegación por tabs
- ✅ Estados vacíos
- ✅ Confirmaciones visuales
- ✅ Swipe to delete
- ✅ Persistencia con SwiftData

## 🔮 Roadmap

### Próximas Features
1. ~~🎮 Feedback háptico~~
2. 📱 Widget
3. 🔔 Notificaciones/Recordatorios
4. 🍎 HealthKit integration
5. ⌚ Apple Watch app
6. 🏆 Sistema de logros
7. 🎨 Temas personalizables
8. 🌐 Sincronización con iCloud
9. 📤 Exportar datos
10. 🔗 Compartir logros

---

**Última actualización**: 8 de Marzo, 2026  
**Versión**: 1.1.0 (con feedback háptico)
