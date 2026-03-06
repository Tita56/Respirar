# 🫁 RespiraApp

Una aplicación moderna para iOS que te ayuda a practicar diferentes técnicas de respiración con guía visual y sonora.

## ✨ Características

### 🎯 5 Patrones de Respiración
1. **4-7-8 Relajante** - Ideal para dormir y reducir ansiedad
2. **Box Breathing** - Técnica militar para concentración
3. **5-5-5 Equilibrio** - Balance perfecto para el día
4. **Respiración Energizante** - Para aumentar energía y vitalidad
5. **Calma Profunda** - Respiración muy lenta para meditación

### 🎨 Interfaz Visual
- Animaciones fluidas del círculo de respiración
- Colores dinámicos según la fase (inhalar, mantener, exhalar, pausa)
- Efectos de glow y sombras
- Instrucciones claras en pantalla
- Contador de ciclos completados

### 🔊 Sistema de Sonido
- Sonidos generados proceduralmente para cada fase
- Tonos diferentes para inhalar, mantener, exhalar y pausar
- Control de activación/desactivación de sonidos
- Sonido de éxito al completar ciclos
- 5 presets de sonido: Campanas, Cuencos Tibetanos, Tonos Puros, Suave y Gong
- **Audio en background**: Continúa incluso con pantalla bloqueada
- **Now Playing**: Información en centro de control y pantalla de bloqueo

### 🎮 Feedback Háptico
- Vibraciones específicas para cada fase de respiración
- Patrón de celebración al completar ciclos
- Feedback en todas las interacciones importantes
- Control para activar/desactivar hápticos
- Intensidades variadas según el contexto

### 📊 Historial y Estadísticas
- Registro automático de todas las sesiones con SwiftData
- Vista de historial organizada por días
- Estadísticas completas:
  - Racha actual y mejor racha de días consecutivos
  - Total de minutos meditados
  - Total de ciclos completados
  - Promedio de duración por sesión
  - Patrón favorito
- Gráficas interactivas con Swift Charts:
  - Minutos por día
  - Patrones más usados
  - Tendencia de ciclos completados
- Filtros por rango de tiempo (semana, mes, año, todo)

### 📱 Funcionalidades
- Selección fácil de patrones
- Controles intuitivos (Comenzar/Detener/Reset)
- Tutorial inicial
- Diseño adaptativo
- Indicador visual de tiempo
- Confirmación visual al guardar sesiones
- Navegación por tabs intuitiva

## 🏗️ Arquitectura

### Archivos Principales

- **ContentView.swift** - Vista principal con la animación y controles
- **BreathingPattern.swift** - Modelo de datos para los patrones
- **SoundManager.swift** - Gestión de audio y generación de sonidos
- **SoundPreset.swift** - Configuración de presets de sonido
- **PatternSelectionView.swift** - Vista de selección de patrones
- **SoundPresetSelectionView.swift** - Vista de selección de presets de sonido
- **BreathingSession.swift** - Modelo SwiftData para sesiones
- **HistoryView.swift** - Vista de historial de sesiones
- **StatisticsView.swift** - Vista de estadísticas y gráficas
- **MainTabView.swift** - Navegación principal por tabs
- **HapticManager.swift** - Gestión de feedback háptico

### Tecnologías Utilizadas

- **SwiftUI** - Framework UI declarativo
- **Swift Concurrency** - async/await para temporizadores
- **AVFoundation** - Reproducción de audio
- **SwiftData** - Persistencia de datos moderna
- **Swift Charts** - Visualización de datos con gráficas
- **Observation** - @Observable para gestión de estado
- **UIKit Haptics** - Feedback háptico táctil
- **Síntesis de audio** - Generación procedural de tonos

## 🚀 Uso

1. Abre la app
2. Lee las instrucciones de bienvenida
3. Selecciona un patrón de respiración tocando el nombre del patrón actual
4. Ajusta el preset de sonido si lo deseas (icono de campana)
5. Presiona "Comenzar" para iniciar la sesión
6. Sigue la animación del círculo y las instrucciones
7. Presiona "Detener" cuando termines - ¡tu sesión se guardará automáticamente!
8. Revisa tu historial y estadísticas en las pestañas correspondientes

### Tabs de Navegación

- **Respirar** 🌬️ - Sesión principal de respiración
- **Historial** 🕐 - Ver todas tus sesiones pasadas organizadas por fecha
- **Estadísticas** 📊 - Analizar tu progreso con gráficas interactivas

## 🎵 Sistema de Sonido

La app genera tonos proceduralmente sin necesidad de archivos de audio externos:

- **Inhalar**: Tono La (440 Hz)
- **Mantener**: Tono Do (523.25 Hz)
- **Exhalar**: Tono Fa (349.23 Hz)
- **Pausa**: Tono Re (293.66 Hz)
- **Síntesis de audio** - Generación procedural de tonos tipo campana con armónicos inarmónicos

Cada tono incluye envolvente de fade in/out para evitar clicks.

## 🔮 Futuras Mejoras

- [x] ~~Vibraciones hápticas~~
- [ ] Recordatorios personalizables
- [ ] Patrones personalizados
- [ ] Integración con HealthKit
- [x] ~~Widget para pantalla de inicio~~
- [ ] Soporte para Apple Watch
- [ ] Modo oscuro mejorado
- [ ] Sonidos de fondo opcionales (naturaleza, lluvia, etc.)
- [ ] Más presets de tonos (flauta, gong adicional)
- [x] ~~Historial de sesiones~~
- [x] ~~Estadísticas y logros~~
- [x] ~~Gráficas con Swift Charts~~
- [ ] Exportar datos a CSV
- [ ] Compartir logros

## 📋 Requisitos

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## 👩‍💻 Desarrollo

Creado por Amada Hernández Borges
Fecha: Marzo 2026

---

**Nota**: Esta app está diseñada para ayudar con técnicas de relajación y no sustituye tratamiento médico profesional.
