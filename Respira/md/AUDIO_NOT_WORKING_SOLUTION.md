# ⚠️ AUDIO EN BACKGROUND NO FUNCIONA - SOLUCIÓN

## 🔴 Problema

El audio se detiene cuando bloqueas la pantalla.

---

## ✅ Solución - Paso a Paso

### **DEBES hacer esto MANUALMENTE en Xcode:**

---

### **Paso 1: Abre Xcode**

Si ya tienes Xcode abierto, continúa al paso 2.

---

### **Paso 2: En el Project Navigator**

1. Mira el panel **IZQUIERDO** de Xcode
2. Busca el icono **AZUL** con el nombre "Respira" (arriba del todo)
3. **Haz CLICK** en ese icono azul

```
Project Navigator (Panel izquierdo)
│
├── 📘 Respira  ← ¡CLICK AQUÍ!
│   ├── 📄 RespiraApp.swift
│   ├── 📄 ContentView.swift
│   └── ...
```

---

### **Paso 3: Selecciona el Target**

1. En el panel **CENTRAL** (después de hacer click en paso 2)
2. Verás dos secciones: "PROJECT" y "TARGETS"
3. En la sección "**TARGETS**"
4. **Haz CLICK** en "**Respira**"

```
Panel Central:

PROJECT
└── Respira

TARGETS
└── Respira  ← ¡CLICK AQUÍ!
```

---

### **Paso 4: Ve a Signing & Capabilities**

1. En la barra superior del panel central
2. Verás tabs: "General", "Signing & Capabilities", etc.
3. **Haz CLICK** en "**Signing & Capabilities**"

```
General | Signing & Capabilities | Resource Tags | ...
            ↑
    ¡CLICK AQUÍ!
```

---

### **Paso 5: Añadir Capability**

1. Busca el botón **"+ Capability"** (esquina superior izquierda del panel)
2. **Haz CLICK** en ese botón
3. Se abrirá un menú con una lista

```
┌────────────────────────┐
│ + Capability  Library   │  ← ¡CLICK AQUÍ!
└────────────────────────┘
```

---

### **Paso 6: Buscar "Background Modes"**

1. En el menú que se abrió
2. Busca "**Background Modes**" (puedes escribir en el buscador)
3. **Haz CLICK** en "Background Modes"

```
┌──────────────────────────┐
│ 🔍 Search...             │
├──────────────────────────┤
│ App Groups               │
│ Associated Domains       │
│ Background Modes  ← AQUÍ │
│ Data Protection          │
│ ...                      │
└──────────────────────────┘
```

---

### **Paso 7: Marcar la Casilla**

1. Después de añadir "Background Modes"
2. Verás una lista de opciones con casillas
3. **Marca la casilla** ✅ "**Audio, AirPlay, and Picture in Picture**"

```
Background Modes
┌──────────────────────────────────────────┐
│ ☐ Location updates                       │
│ ☐ Background fetch                       │
│ ☑ Audio, AirPlay, and Picture in Picture │ ← ¡MARCA ESTO!
│ ☐ Voice over IP                          │
│ ☐ External accessory communication       │
│ ...                                      │
└──────────────────────────────────────────┘
```

---

### **Paso 8: Verifica**

Deberías ver algo así:

```
Signing & Capabilities

Signing
├── Team: Tu nombre
└── Bundle Identifier: com...

Background Modes
└── ✅ Audio, AirPlay, and Picture in Picture  ← DEBE ESTAR MARCADO
```

---

### **Paso 9: Limpia el Build**

1. En el menú superior de Xcode
2. Click en "**Product**"
3. Click en "**Clean Build Folder**"
4. O presiona: **Cmd + Shift + K**

```
Product → Clean Build Folder
```

---

### **Paso 10: Compila de Nuevo**

1. Presiona **Cmd + R**
2. O click en el botón ▶️ "Play" de Xcode

---

## 🧪 Prueba

1. Abre la app
2. Inicia una sesión de respiración
3. **Bloquea el iPhone** (botón lateral)
4. ¿Escuchas los sonidos? 

- **SÍ** → ¡Funciona! ✅
- **NO** → Continúa leyendo

---

## 🐛 Si AÚN NO funciona

### **Opción A: Usa la Vista de Debug**

1. En la app, ve al tab "**Audio**" (tab nuevo)
2. Presiona "**Verificar Configuración**"
3. Presiona "**Ejecutar Pruebas**"
4. Lee los resultados

### **Opción B: Verifica Manualmente**

1. ¿Marcaste la casilla correcta? (Paso 7)
2. ¿Limpiaste el build? (Paso 9)
3. ¿Recompilaste? (Paso 10)

### **Opción C: Reinicia Xcode**

A veces Xcode necesita reiniciarse:

1. Cierra Xcode completamente
2. Abre Xcode de nuevo
3. Abre el proyecto
4. Limpia build (Cmd+Shift+K)
5. Compila (Cmd+R)

---

## 📸 Capturas de Referencia

### **Donde está el botón "+ Capability":**

```
┌────────────────────────────────────────────┐
│ Respira (Target)                           │
├────────────────────────────────────────────┤
│ General  Signing & Capabilities  Info ...  │  ← Tabs
├────────────────────────────────────────────┤
│ + Capability     Library ▼                  │  ← Botón AQUÍ
├────────────────────────────────────────────┤
│                                            │
│ [Contenido de capabilities]                │
│                                            │
└────────────────────────────────────────────┘
```

---

## ❓ Preguntas Frecuentes

### "No veo el botón + Capability"

**Solución:**
- Asegúrate de estar en "Signing & Capabilities"
- Asegúrate de haber seleccionado el TARGET (no el PROJECT)

### "Ya marqué la casilla pero no funciona"

**Solución:**
1. Desmarca la casilla
2. Guarda (Cmd+S)
3. Vuelve a marcar
4. Limpia build
5. Recompila

### "Compila pero el audio se detiene"

**Verifica:**
- ¿El sonido está activado en la app?
- ¿El volumen del iPhone está arriba?
- ¿La sesión está activa?

---

## 📞 Última Opción

Si después de TODO esto NO funciona:

1. Captura de pantalla de "Signing & Capabilities"
2. Captura de la vista "Audio" (tab debug)
3. Envía las capturas

---

## ✅ Checklist Final

Marca cada paso:

- [ ] Abrí Xcode
- [ ] Click en icono azul "Respira"
- [ ] Click en TARGET "Respira"
- [ ] Click en "Signing & Capabilities"
- [ ] Click en "+ Capability"
- [ ] Añadí "Background Modes"
- [ ] Marqué ✅ "Audio, AirPlay, and Picture in Picture"
- [ ] Limpié build (Cmd+Shift+K)
- [ ] Recompilé (Cmd+R)
- [ ] Probé bloqueando la pantalla
- [ ] ¿Funciona? ____

---

**Si completaste TODOS los pasos y NO funciona, hay un problema diferente.**

---

**Fecha**: 8 de Marzo, 2026
