# دليل إصلاح مشكلة Android Emulator

## المشاكل المكتشفة:
1. ❌ **cmdline-tools مفقود** - مكون مهم من Android SDK
2. ❌ **تراخيص Android غير مقبولة**
3. ❌ **الإيموليتر لا يبدأ (exited with code 1)**

## الحلول:

### الحل 1: تثبيت Android SDK Command-line Tools

#### الطريقة الأولى: من خلال Android Studio
1. افتح **Android Studio**
2. اذهب إلى **Tools** → **SDK Manager**
3. في تبويب **SDK Tools**، تأكد من تفعيل:
   - ✅ **Android SDK Command-line Tools (latest)**
   - ✅ **Android SDK Platform-Tools**
   - ✅ **Android Emulator**
4. اضغط **Apply** وانتظر التثبيت

#### الطريقة الثانية: التحميل اليدوي
1. اذهب إلى: https://developer.android.com/studio#command-line-tools-only
2. حمّل **Command line tools only** لنظام Windows
3. استخرج الملفات إلى: `C:\Users\hager\AppData\Local\Android\Sdk\cmdline-tools\latest\`
4. تأكد من أن المسار يحتوي على: `bin\sdkmanager.bat`

### الحل 2: قبول تراخيص Android

بعد تثبيت cmdline-tools، شغّل:

```powershell
flutter doctor --android-licenses
```

أو مباشرة:

```powershell
$env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk"
& "$env:ANDROID_HOME\cmdline-tools\latest\bin\sdkmanager.bat" --licenses
```

اضغط **y** لقبول جميع التراخيص.

### الحل 3: إصلاح مشكلة بدء الإيموليتر

#### أ) حذف الإيموليتر القديم وإنشاء واحد جديد:

```powershell
# حذف الإيموليتر القديم
flutter emulators --delete Pixel_5

# إنشاء إيموليتر جديد
flutter emulators --create --name Pixel_5
```

#### ب) التحقق من إعدادات Virtualization:

1. **تحقق من Hyper-V:**
   - افتح **Windows Features** (Turn Windows features on or off)
   - تأكد من تفعيل:
     - ✅ **Windows Hypervisor Platform**
     - ✅ **Virtual Machine Platform**
   - أعد تشغيل الكمبيوتر

2. **تحقق من BIOS:**
   - تأكد من تفعيل **Virtualization Technology (VT-x/AMD-V)** في BIOS

#### ج) تنظيف ملفات الإيموليتر:

```powershell
# إيقاف جميع عمليات الإيموليتر
adb kill-server
taskkill /F /IM qemu-system-x86_64.exe 2>$null
taskkill /F /IM emulator.exe 2>$null

# حذف ملفات الإيموليتر القديمة (اختياري)
$avdPath = "$env:LOCALAPPDATA\Android\Sdk\.android\avd"
Remove-Item -Path "$avdPath\Pixel_5.avd" -Recurse -Force -ErrorAction SilentlyContinue
```

### الحل 4: تحديث Flutter و Android SDK

```powershell
# تحديث Flutter
flutter upgrade

# تحديث Android SDK
$env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk"
& "$env:ANDROID_HOME\cmdline-tools\latest\bin\sdkmanager.bat" --update
```

### الحل 5: تشغيل الإيموليتر يدوياً للتحقق من الأخطاء

```powershell
$env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk"
& "$env:ANDROID_HOME\emulator\emulator.exe" -avd Pixel_5 -verbose
```

هذا سيعرض أخطاء مفصلة تساعد في التشخيص.

## خطوات سريعة للإصلاح:

1. ✅ تثبيت **Android SDK Command-line Tools** من Android Studio
2. ✅ قبول التراخيص: `flutter doctor --android-licenses`
3. ✅ حذف الإيموليتر القديم: `flutter emulators --delete Pixel_5`
4. ✅ إنشاء إيموليتر جديد: `flutter emulators --create --name Pixel_5`
5. ✅ التحقق من Flutter: `flutter doctor -v`
6. ✅ تشغيل الإيموليتر: `flutter emulators --launch Pixel_5`

## ملاحظات مهمة:

- تأكد من وجود مساحة كافية على القرص (الإيموليتر يحتاج ~2GB)
- تأكد من تفعيل Virtualization في BIOS
- أعد تشغيل الكمبيوتر بعد تغيير إعدادات Windows Features
- إذا استمرت المشكلة، جرب إعادة تثبيت Android Studio

