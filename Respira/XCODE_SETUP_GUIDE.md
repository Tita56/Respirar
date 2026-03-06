# 🛠️ INSTRUCCIONES: Añadir Background Audio en Xcode

## ⚠️ PASO OBLIGATORIO

Sin este paso, el audio se detendrá cuando bloquees la pantalla.

---

## 📝 Paso a Paso

### **1. Abre tu proyecto en Xcode**

```
File → Open → Respira.xcodeproj
```

---

### **2. Selecciona el Proyecto**

En el **Project Navigator** (panel izquierdo):
- Click en el icono **azul** del proyecto (arriba del todo)
- El nombre será "Respira"

```
📁 Project Navigator
  └── 📘 Respira  ← Click aquí
       ├── 📄 RespiraApp.swift
       ├── 📄 ContentView.swift
       └── ...
```

---

### **3. Selecciona el Target**

En el panel central, bajo **"TARGETS"**:
- Click en **"Respira"**

```
PROJECT
  └── Respira

TARGETS
  └── Respira  ← Click aquí
```

---

### **4. Ve a Signing & Capabilities**

En la barra superior del editor:
- Click en la pestaña **"Signing & Capabilities"**

```
General | Signing & Capabilities | Resource Tags | Info | Build Settings | ...
            ↑
       Click aquí
```

---

### **5. Añade Background Modes**

- Click en el botón **"+ Capability"** (esquina superior izquierda)
- Aparecerá un popup con lista de capabilities
- Busca **"Background Modes"**
- Click en **"Background Modes"**

```
┌─────────────────────────────┐
│  Add Capability             │
├─────────────────────────────┤
│  🔍 Search                   │
│  ─────────────────────      │
│  App Groups                  │
│  Associated Domains          │
│  Background Modes  ← Click   │
│  Data Protection             │
│  ...                         │
└─────────────────────────────┘
```

---

### **6. Marca Audio**

Una vez añadido "Background Modes", verás una lista de opciones.

Marca la casilla:
- ✅ **"Audio, AirPlay, and Picture in Picture"**

```
Background Modes
┌─────────────────────────────────────────────┐
│  □ Location updates                          │
│  □ Background fetch                          │
│  ✅ Audio, AirPlay, and Picture in Picture   │  ← Marca esto
│  □ Voice over IP                             │
│  □ External accessory communication          │
│  □ Uses Bluetooth LE accessories             │
│  □ Acts as a Bluetooth LE accessory          │
│  □ Background processing                     │
│  □ Remote notifications                      │
└─────────────────────────────────────────────┘
```

---

### **7. Verifica**

Deberías ver algo así:

```
Signing & Capabilities
├── Signing (Automatically manage signing)
│   ├── Team: Tu nombre
│   └── Bundle Identifier: com.tuempresa.Respira
│
└── Background Modes
    └── ✅ Audio, AirPlay, and Picture in Picture
```

---

### **8. Guarda**

- Presiona **Cmd+S** para guardar
- O simplemente continúa (Xcode guarda automáticamente)

---

### **9. Limpia el Build**

Para asegurar que los cambios se apliquen:

```
Product → Clean Build Folder
```

O presiona: **Cmd + Shift + K**

---

### **10. Compila y Ejecuta**

```
Product → Run
```

O presiona: **Cmd + R**

---

## ✅ ¡Listo!

Ahora tu app puede reproducir audio en background.

---

## 🧪 Prueba

1. Ejecuta la app
2. Inicia una sesión de respiración
3. **Bloquea el iPhone** (botón lateral)
4. **¿Escuchas los sonidos?** ✅

Si SÍ → ¡Perfecto! 🎉  
Si NO → Revisa que marcaste la casilla correcta

---

## 🐛 Troubleshooting

### "No veo la opción Background Modes"

**Solución:**
- Asegúrate de estar en el **Target** (no en el Project)
- Asegúrate de estar en **"Signing & Capabilities"**
- Prueba cerrar y reabrir Xcode

### "La casilla está marcada pero no funciona"

**Solución:**
1. Desmarca la casilla
2. Guarda (Cmd+S)
3. Vuelve a marcar
4. Clean Build Folder (Cmd+Shift+K)
5. Compila de nuevo

### "No encuentro el botón + Capability"

**Ubicación:**
- Está en la esquina **superior izquierda** del panel central
- Justo debajo de las pestañas "General", "Signing & Capabilities", etc.
- Dice "+ Capability" con un símbolo de plus

---

## 📸 Referencia Visual

```
┌──────────────────────────────────────────────────────────┐
│  Respira                                                  │
├──────────────────────────────────────────────────────────┤
│  General | Signing & Capabilities | Resource Tags | ...  │
├──────────────────────────────────────────────────────────┤
│  + Capability  Library                                    │  ← Botón aquí
├──────────────────────────────────────────────────────────┤
│                                                           │
│  Signing (Automatically manage signing)                   │
│  ┌─────────────────────────────────────────────────────┐ │
│  │  Team: Tu Equipo                                     │ │
│  │  Bundle Identifier: com.example.Respira              │ │
│  └─────────────────────────────────────────────────────┘ │
│                                                           │
│  Background Modes                                         │
│  ┌─────────────────────────────────────────────────────┐ │
│  │  ✅ Audio, AirPlay, and Picture in Picture           │ │
│  └─────────────────────────────────────────────────────┘ │
│                                                           │
└──────────────────────────────────────────────────────────┘
```

---

## 💡 Notas

- Esta configuración es **obligatoria** para audio en background
- Solo necesitas hacerlo **una vez**
- Los cambios se guardan en el archivo del proyecto
- Es compatible con el App Store

---

## ✨ Después de Configurar

Una vez configurado correctamente, podrás:

- 🔒 Bloquear el iPhone mientras escuchas
- 📱 Cambiar de app sin interrumpir el audio
- 🎛️ Ver info en el centro de control
- 🔋 Ahorrar batería (pantalla apagada)

---

**¿Necesitas más ayuda?**  
Consulta: `BACKGROUND_AUDIO_GUIDE.md` para más detalles técnicos.

---

**Versión**: 1.2.0  
**Fecha**: 8 de Marzo, 2026
