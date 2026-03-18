# 🧘‍♀️ Respira

> Una aplicación iOS nativa para practicar técnicas de respiración consciente y mejorar tu bienestar mental.

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-✓-green.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

## 📱 Características

### 🎯 Funcionalidades Principales

- **Múltiples patrones de respiración** - Técnicas probadas para diferentes necesidades
- **Interfaz minimalista** - Diseño limpio y enfocado, sin distracciones
- **Círculo de respiración animado** - Visualización fluida y envolvente
- **Audio en background** - Practica con los ojos cerrados
- **Feedback háptico** - Siente cada transición sin mirar la pantalla
- **Guardado de sesiones** - Seguimiento de tu progreso con SwiftData
- **Presets de sonido** - Diferentes ambientes para tu práctica
- **Control desde el Centro de Control** - Gestiona tu sesión sin abrir la app

### 🌬️ Patrones de Respiración

La app incluye técnicas diseñadas para:

- 💙 **Reducir estrés y ansiedad** - Respiración calmante
- 🧠 **Mejorar concentración** - Box Breathing
- 🌙 **Facilitar el sueño** - Técnica 4-7-8
- ⚡ **Aumentar energía** - Respiración energizante

## 🛠️ Tecnologías

- **SwiftUI** - Interfaz de usuario declarativa
- **SwiftData** - Persistencia de datos moderna
- **AVFoundation** - Reproducción de audio en background
- **Core Haptics** - Feedback táctil personalizado
- **Combine** - Gestión reactiva de estados

## 📋 Requisitos

- iOS 17.0+
- Xcode 15.0+
- iPhone (probado en iPhone 11 Pro)

## 🚀 Instalación

### Clonar el repositorio

```bash
git clone https://github.com/tuusuario/Respira.git
cd Respira
```

### Abrir en Xcode

```bash
open Respira.xcodeproj
```

### Compilar y ejecutar

1. Selecciona tu dispositivo o simulador
2. Presiona `Cmd + R` para compilar y ejecutar

## 📖 Uso

### Inicio Rápido

1. **Selecciona un patrón** - Toca el nombre del patrón para ver todas las opciones
2. **Configura el audio** - Elige un preset de sonido o silencia la app
3. **Presiona "Comenzar"** - Inicia tu sesión de respiración
4. **Cierra los ojos** - Sigue las vibraciones y el audio
5. **Respira** - La app te guiará en cada fase

### Características Avanzadas

- **Audio en background**: La app continúa funcionando incluso con la pantalla bloqueada
- **Control desde Centro de Control**: Gestiona la reproducción sin abrir la app
- **Historial de sesiones**: Revisa tus sesiones guardadas automáticamente

## 🎨 Diseño

La interfaz está optimizada para:

- **Uso con ojos cerrados** - Todo controlado por audio y vibraciones
- **Minimalismo** - Sin elementos visuales innecesarios
- **Accesibilidad** - Textos grandes, colores claros, navegación simple
- **Fluidez** - Animaciones suaves y transiciones naturales

## 📂 Estructura del Proyecto

```
Respira/
├── ContentView.swift           # Vista principal
├── Models/
│   ├── BreathingPattern.swift  # Patrones de respiración
│   ├── BreathPhase.swift       # Tipos de fases
│   └── BreathingSession.swift  # Modelo de sesión
├── Managers/
│   ├── SoundManager.swift      # Gestión de audio
│   ├── HapticManager.swift     # Feedback háptico
│   └── BackgroundAudioManager.swift # Audio en background
└── Views/
    ├── PatternSelectionView.swift
    └── SoundPresetSelectionView.swift
```

## 🔧 Configuración

### Audio en Background

La app está configurada para reproducir audio en background. Asegúrate de que:

1. En las capacidades del target está habilitado **"Audio, AirPlay, and Picture in Picture"**
2. El modo background está configurado en `Info.plist`

### Permisos

No se requieren permisos especiales. La app funciona completamente offline.

## 🤝 Contribuir

Las contribuciones son bienvenidas. Para cambios importantes:

1. Fork el proyecto
2. Crea tu rama de características (`git checkout -b feature/NuevaCaracteristica`)
3. Commit tus cambios (`git commit -m 'Agrega nueva característica'`)
4. Push a la rama (`git push origin feature/NuevaCaracteristica`)
5. Abre un Pull Request

## 📝 Roadmap

### Futuras mejoras

- [ ] Widget para pantalla de inicio
- [ ] Notificaciones de recordatorio
- [ ] Estadísticas y gráficas de progreso
- [ ] Patrones personalizados
- [ ] Integración con Apple Health
- [ ] Soporte para iPad y Mac
- [ ] Modo oscuro mejorado
- [ ] Compartir sesiones

## 👩‍💻 Autora

**Amada Hernández Borges**

- Creado el 16 de febrero de 2025

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 🙏 Agradecimientos

- Inspirado en técnicas de respiración milenarias y estudios modernos de mindfulness
- Diseño minimalista influenciado por las mejores prácticas de meditación
- Gracias a la comunidad de SwiftUI por los recursos y ejemplos

---

**¡Respira profundo y disfruta del momento presente!** 🌬️✨
