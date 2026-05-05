# 🚀 Hamburguesa Fácil — Guía Completa de Publicación en Play Store

## Checklist Pre-lanzamiento

### ✅ Código y Build
- [x] `applicationId` cambiado a `com.sazardev.hamburguesa_facil`
- [x] `versionCode = 1`, `versionName = "1.0.0"`
- [x] `minSdkVersion 21` (Android 5.0 — cubre ~97% de dispositivos)
- [x] Keystore firmado generado (`hamburguesa-keystore.jks`)
- [x] `key.properties` configurado con datos de firma
- [x] Modo release con `minifyEnabled true` + `shrinkResources true`
- [x] ProGuard rules configuradas
- [x] `allowBackup="false"` en AndroidManifest (seguridad)
- [x] Launcher icons generados (mipmap-hdpi hasta mipmap-xxxhdpi)
- [x] Adaptive icons configurados

### 🎨 Assets Gráficos (pendiente — ver image_prompts.md)
- [ ] Feature Graphic (1024×500 px)
- [ ] Screenshots mínimo 2, recomendado 6-8
- [ ] App Icon 512×512 PNG (sin canal alpha)
- [ ] Video promocional (opcional, muy recomendado)

### 📝 Store Listing (ver play_store_listing.md)
- [ ] Título: "Hamburguesa Fácil – Arma tu Burger"
- [ ] Descripción corta (80 chars)
- [ ] Descripción completa con keywords SEO
- [ ] Categoría: Food & Drink
- [ ] Tags configurados
- [ ] Idiomas: es (principal), en (opcional)

### 📋 Requisitos Legales
- [ ] Privacy Policy URL (requerido)
- [ ] Email de soporte
- [ ] Formulario de content rating completado en Play Console

---

## Paso a Paso: Compilar y Firmar

### 1. Generar el App Bundle (recomendado para Play Store)
```powershell
cd C:\Users\Omar\Documents\work\hamburguesa_facil
flutter build appbundle --release
```
Output: `build\app\outputs\bundle\release\app-release.aab`

### 2. Alternativamente: APK Universal
```powershell
flutter build apk --release --split-per-abi
```
Outputs:
- `build\app\outputs\flutter-apk\app-arm64-v8a-release.apk`  ← Más común
- `build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk`
- `build\app\outputs\flutter-apk\app-x86_64-release.apk`

### 3. Verificar firma del APK
```powershell
& "C:\Program Files\Android\Android Studio1\jbr\bin\keytool.exe" -printcert -jarfile build\app\outputs\flutter-apk\app-arm64-v8a-release.apk
```

---

## Subir a Google Play Console

### Paso 1: Crear cuenta de desarrollador
- Ir a https://play.google.com/console
- Pagar $25 USD (pago único)
- Llenar información de la cuenta

### Paso 2: Crear la aplicación
1. "Create app"
2. App name: **Hamburguesa Fácil**
3. Default language: **Spanish (Latin America) — es-419**
4. App or game: **App**
5. Free or paid: **Free**

### Paso 3: Store listing
1. Ir a "Store presence" → "Main store listing"
2. Llenar con contenido de `play_store_listing.md`
3. Subir screenshots de `image_prompts.md`
4. Subir Feature Graphic
5. Subir App Icon (512×512)

### Paso 4: Content rating
1. Ir a "Policy" → "App content" → "Content rating"
2. Completar cuestionario
3. La app es **Everyone (Everyone 10+)** no aplica

### Paso 5: Subir el bundle
1. Ir a "Release" → "Testing" → "Internal testing" (primero)
2. "Create new release"
3. Subir el `.aab`
4. Agregar release notes: "Versión inicial de Hamburguesa Fácil 🍔"
5. Revisar y publicar

### Paso 6: Producción
Después de ~1 semana en internal testing:
1. "Release" → "Production"
2. "Create new release"
3. Seleccionar el bundle de internal testing
4. "Start rollout to Production"

---

## SEO Tips para Play Store (ASO)

### Palabras clave incluidas en el título y descripción:
- `hamburguesa` — Alta búsqueda en LATAM
- `recetas hamburguesas` — Long-tail
- `armar hamburguesa` — Específica del app
- `cocina fácil` — Amplia audiencia
- `sin gluten vegetariana` — Nichos con alta intención

### Estrategia de ratings:
- Agregar prompt de reseña después de que el usuario guarde su primera hamburguesa
- Usar `in_app_review` plugin de Flutter después del éxito

---

## Keystore — DATOS IMPORTANTES

⚠️ **NUNCA pierdas el keystore. Sin él, no puedes actualizar tu app.**

| Campo | Valor |
|-------|-------|
| Archivo | `android/app/hamburguesa-keystore.jks` |
| Alias | `hamburguesa_key` |
| Store Password | `hamburguesa2024` |
| Key Password | `hamburguesa2024` |
| Válido hasta | ~27 años (10,000 días) |

**Respaldo recomendado:**
- Copia en un lugar seguro fuera del repositorio (Google Drive, Bitwarden, etc.)
- El archivo `key.properties` ya está en `.gitignore`

---

## Próximas versiones sugeridas (roadmap)

### v1.1.0
- [ ] In-app review prompt
- [ ] Compartir hamburguesa como imagen (Share sheet)
- [ ] Animaciones mejoradas al guardar

### v1.2.0  
- [ ] Modo "Restaurante" — calcular ingredientes para N personas
- [ ] Lista de compras exportable
- [ ] Modo offline total confirmado

### v2.0.0
- [ ] Comunidad — comparte tu burger con otros usuarios
- [ ] Rating de combinaciones
- [ ] Ingredientes personalizados
