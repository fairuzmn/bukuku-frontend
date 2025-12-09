# Bukuku Frontend 📱

---

## 🏗 Architecture

This project follows a **Feature-First Clean Architecture** combined with **GetX** for state management and dependency injection.

Each feature (e.g., `order`, `kitchen`, `auth`) is self-contained with its own layers:

1.  **Domain Layer** (Inner Layer)
    * **Entities:** Pure Dart objects representing the business data.
    * **Repository Interfaces:** Abstract classes defining the contract for data operations.
2.  **Data Layer** (Outer Layer)
    * **Repository Implementation:** Implements the domain interfaces, handling data retrieval.
    * **Request/Response Models:** DTOs (Data Transfer Objects) for API communication.
    * **Data Sources:** calls to `DioClient`.
3.  **Presentation Layer** (UI Layer)
    * **Controller:** GetX controllers managing state (`Rx` variables) and business logic.
    * **View:** Flutter widgets responsible for rendering the UI.
    * **Binding:** Dependency injection setup for the feature.

### 📂 Project Structure

```text
lib/
├── core/                   # Core configurations (Network, Env, Constants)
├── features/               # Feature-based modules
│   ├── auth/               # Login & OTP
│   ├── category/           # Category CRUD
│   ├── kitchen/            # Kitchen Display System
│   ├── menu_item/          # Product Management
│   ├── order/              # POS & Checkout logic
│   └── table/              # Table Management
├── shared/                 # Reusable components (Buttons, Inputs, Shimmers)
├── routes/                 # App Navigation & Route definitions
├── main_dev.dart           # Entry point for Development environment
└── app.dart                # Main App Widget
```

---

## 🛠 Tech Stack

* **Framework:** Flutter (SDK ^3.38.3)
* **State Management:** [GetX](https://pub.dev/packages/get)
* **Networking:** [Dio](https://pub.dev/packages/dio) + [fpdart](https://pub.dev/packages/fpdart) (Functional Error Handling)
* **Responsiveness:** [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
* **Environment:** [envied](https://pub.dev/packages/envied)
* **Storage:** [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
* **Utils:** `intl` (Currency Formatting), `image_picker`, `shimmer`.

---

## ⚙️ Setup & Installation

### 1. Prerequisites
* Flutter SDK installed.
* Android Studio / VS Code.

### 2. Clone & Install Dependencies
```bash
git clone https://github.com/fairuzmn/bukuku-frontend.git
cd bukuku-frontend
flutter pub get
```

### 3. Code Generation
This project uses `build_runner` for environment variables and asset generation. Run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the App
Since the project uses flavors/environments, run using the specific entry point:

**Development:**
```bash
flutter run -t lib/main_dev.dart
```

---

## 📜 Scripts & Commands (RPS)

This project uses [RPS](https://pub.dev/packages/rps) to manage common scripts defined in `pubspec.yaml`.

| Command | Action | Description |
| :--- | :--- | :--- |
| **Code Generation** | | |
| `rps runner build` | `dart run build_runner build` | Runs code generation once. |
| `rps runner clean` | `dart run build_runner clean` | Cleans the build cache. |
| `rps runner watch` | `dart run build_runner watch` | Watches for file changes and auto-generates code. |
| `rps runner rebuild` | *Clean + Build* | Cleans cache and runs a fresh build. |
| **Maintenance** | | |
| `rps cleanup` | `dart fix --apply` | Applies automated fixes to the code. |
| **Build & Release** | | |
| `rps build dev` | `flutter build apk` | Builds the APK for the **dev** flavor. |
| `rps release dev` | *Fix + Clean + Build* | Optimizes imports, cleans project, and builds Dev APK. |
| **Assets** | | |
| `rps icon generate` | `flutter_launcher_icons` | Generates app icons from assets. |
| `rps splash generate` | `flutter_native_splash` | Generates the native splash screen. |

---

## 🔌 API Integration

The app uses `DioClient` configured in `lib/core/network/`.
* **Base URL:** Configured via `AppConfig` / `Env`.
* **Interceptors:**
    * `AuthInterceptor`: Automatically attaches the Bearer token to requests.
    * `HeaderInterceptor`: Adds standard headers (JSON, etc.).

---

## 🎨 UI & Theming

* **Design System:** Located in `lib/shared/theme/` (`AppColor`, `AppTypography`).
* **Components:** Custom widgets in `lib/shared/components/` ensures UI consistency across the app.
* **Responsiveness:** All sizing uses `.w`, `.h`, `.sp` extensions from `flutter_screenutil` to support various screen sizes.