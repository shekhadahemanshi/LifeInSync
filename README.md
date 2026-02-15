# Digital Wellbeing App - UI Frontend

## Setup for Backend Integration
1. Run `flutter pub get`.
2. Add your `google-services.json` to `android/app/`.
3. Run `flutterfire configure` to generate `firebase_options.dart`.
4. Update `baseUrl` in `lib/services/api_service.dart` with your FastAPI IP.

## Current UI Modules
* **Usage:** Card-based stats (Emerald Theme).
* **Focus:** Animated timer (LayoutBuilder fixed).
* **Fatigue:** Animated Gauge (using percent_indicator).
* **Auth:** Fully validated Login/Register with Theme Toggle.