# 📱 Configuración de Widgets para Respira

## ⚙️ Pasos de Configuración en Xcode

### 1. Añadir Widget Extension

1. **File > New > Target**
2. Selecciona **Widget Extension**
3. Nombre: `RespiraWidget`
4. Marca **Include Configuration Intent** (opcional)
5. Haz clic en **Finish**
6. Si pregunta sobre activación de scheme, selecciona **Activate**

### 2. Configurar App Groups

Los widgets corren en un proceso separado de la app principal, por lo que necesitas compartir datos mediante App Groups.

#### En el Target Principal (Respira):
1. Selecciona el target **Respira**
2. Ve a **Signing & Capabilities**
3. Haz clic en **+ Capability**
4. Selecciona **App Groups**
5. Haz clic en **+** y añade: `group.com.respira.shared`
   (Puedes usar tu propio identificador, pero asegúrate de actualizar `AppGroup.swift`)

#### En el Target del Widget (RespiraWidget):
1. Selecciona el target **RespiraWidget**
2. Ve a **Signing & Capabilities**
3. Haz clic en **+ Capability**
4. Selecciona **App Groups**
5. Haz clic en **+** y añade: `group.com.respira.shared` (el mismo que antes)

### 3. Añadir Archivos al Target del Widget

Los siguientes archivos deben estar en **ambos** targets (Respira y RespiraWidget):

1. Selecciona cada archivo en el Project Navigator
2. En el Inspector de Archivos (panel derecho), marca ambos targets:
   - ✅ Respira
   - ✅ RespiraWidget

**Archivos que deben compartirse:**
- `AppGroup.swift` ✅
- `WidgetDataManager.swift` ✅
- `BreathingSession.swift` ✅
- `BreathingPattern.swift` ✅

**Archivos SOLO para el Widget:**
- `RespiraWidget.swift`
- `RespiraQuickActionWidget.swift`
- `RespiraWidgetBundle.swift`

### 4. Actualizar Info.plist del Widget (si es necesario)

Si tu app requiere permisos especiales, asegúrate de añadirlos también al Info.plist del widget.

### 5. Configurar Scheme

1. Ve a **Product > Scheme > Edit Scheme**
2. Asegúrate de que el scheme del widget esté configurado correctamente
3. Puedes crear un scheme para ejecutar el widget directamente durante desarrollo

### 6. Eliminar el archivo de ejemplo

Si Xcode creó un archivo de ejemplo del widget, elimínalo:
- Busca un archivo llamado `RespiraWidget.swift` en el grupo del widget que Xcode creó
- Elimínalo si existe (nosotros creamos uno nuevo)

### 7. Actualizar RespiraWidgetBundle.swift

Si Xcode creó un archivo principal del widget, reemplázalo con nuestro `RespiraWidgetBundle.swift`.

En el archivo principal del widget, asegúrate de que el atributo `@main` esté SOLO en `RespiraWidgetBundle.swift` y NO en `RespiraWidget.swift`.

---

## 🚀 Tipos de Widgets Implementados

### 1. Widget de Estadísticas (`RespiraWidget`)

**Tamaños disponibles:**
- **Small**: Muestra racha actual y total de sesiones
- **Medium**: Muestra racha + patrón favorito
- **Large**: Vista completa con todas las estadísticas
- **Lock Screen (Circular)**: Racha en un círculo
- **Lock Screen (Rectangular)**: Racha y sesiones
- **Lock Screen (Inline)**: Texto simple con racha

### 2. Widget de Acceso Rápido (`RespiraQuickActionWidget`)

**Tamaños disponibles:**
- **Medium**: 2 botones para patrones populares
- **Large**: 5 botones para todos los patrones

**Características:**
- Botones interactivos usando App Intents
- Inicia la app con el patrón seleccionado
- Funciona en iOS 17+

---

## 🔄 Cómo Funciona la Sincronización

1. **Cuando guardas una sesión:**
   - La app guarda en SwiftData
   - `WidgetDataManager` actualiza UserDefaults compartido
   - Se recarga el timeline del widget automáticamente

2. **Cuando tocas un botón del widget:**
   - Se ejecuta un `AppIntent`
   - Se guarda el patrón seleccionado en UserDefaults
   - Se abre la app
   - `ContentView` detecta el patrón y lo inicia automáticamente

---

## 🧪 Probar los Widgets

### En el Simulador:

1. Ejecuta el scheme **Respira**
2. En el simulador, mantén presionada la pantalla de inicio
3. Toca el botón **+** en la esquina superior
4. Busca **Respira**
5. Selecciona el widget que quieras probar

### En el Scheme del Widget:

1. Selecciona **RespiraWidget** scheme
2. Selecciona el tamaño del widget en **Edit Scheme > Run > Widget**
3. Ejecuta (⌘R)
4. El widget se mostrará directamente

---

## 📊 Datos que se Comparten

**Desde la App al Widget:**
- ✅ Racha actual
- ✅ Total de sesiones
- ✅ Fecha de última sesión
- ✅ Patrón favorito
- ✅ Icono del patrón favorito

**Desde el Widget a la App:**
- ✅ Patrón seleccionado para iniciar

---

## 🐛 Solución de Problemas

### El widget no muestra datos:

1. Verifica que el App Group esté configurado en **ambos** targets
2. Asegúrate de que `AppGroup.identifier` coincida con el configurado
3. Verifica que los archivos compartidos estén en ambos targets

### El widget no se actualiza:

1. Asegúrate de llamar `WidgetCenter.shared.reloadAllTimelines()`
2. Verifica que `WidgetDataManager.shared.updateWidgetData()` se llame al guardar

### Los botones no funcionan:

1. Verifica que uses iOS 17+ (App Intents requieren iOS 17)
2. Asegúrate de que el App Intent tenga el modificador correcto
3. Verifica que `checkForWidgetAction()` esté en `.onAppear`

### Error de compilación:

1. Verifica que todos los archivos compartidos estén en ambos targets
2. Asegúrate de que `@main` esté SOLO en `RespiraWidgetBundle.swift`

---

## 📱 Siguientes Pasos Opcionales

### 1. Widget Configurable

Puedes hacer que el usuario seleccione qué estadística ver:
- Añade `AppIntentConfiguration` en lugar de `StaticConfiguration`
- Crea un `AppIntent` para configuración

### 2. Timeline Inteligente

Actualiza el widget en momentos estratégicos:
- A las 8:00 AM (para recordar la sesión matutina)
- A las 20:00 PM (para sesión nocturna)
- Cuando se rompa una racha

### 3. Widget con Live Activity

Para sesiones activas, muestra el progreso en tiempo real:
- Usa Live Activities para mostrar la respiración actual
- Actualiza en tiempo real durante la sesión

### 4. Complicaciones de Apple Watch

Extiende el widget a watchOS:
- Usa los mismos datos compartidos
- Crea vistas específicas para watchOS

---

## 📚 Referencias

- [WidgetKit Documentation](https://developer.apple.com/documentation/widgetkit)
- [App Intents Documentation](https://developer.apple.com/documentation/appintents)
- [App Groups Documentation](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups)

---

¡Tu widget de Respira está listo! 🎉

Si tienes preguntas, revisa la sección de solución de problemas o consulta la documentación oficial de Apple.
