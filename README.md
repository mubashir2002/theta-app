<p align="center">
  <h1 align="center">🌙 Theta</h1>
  <p align="center"><strong>Your all-in-one sanctuary for mind, body, and soul.</strong></p>
  <p align="center">
    A beautifully crafted Flutter wellness companion app featuring meditation, journaling, cycle tracking, mood boards, and daily horoscopes — all wrapped in an elegant, animated UI.
  </p>
</p>

---

## ✨ Overview

**Theta** is a holistic wellness app designed to help users cultivate mindfulness, self-awareness, and personal growth. It combines five powerful wellness tools into a single, beautifully designed experience with smooth animations, dark mode support, and an intuitive interface.

The app is built entirely with **Flutter** and uses no backend — all data is managed locally within the app state. It targets Android, iOS, Web, Linux, macOS, and Windows.

---

## 📱 Screens & Features

### 1. 🌸 Splash Screen (`splash_screen.dart`)

The entry point of the app. Welcomes users with an elegant animated experience.

| Section | Description |
|---------|-------------|
| **App Logo** | "Theta" title in Playfair Display with dark red branding |
| **Subtitle** | "Your all-in-one sanctuary for mind, body, and soul." |
| **Sliding Text Carousel** | 4 rotating motivational texts with smooth slide + fade animation, auto-cycles every 3 seconds |
| **Dot Indicators** | Animated expanding/collapsing dots showing current text position |
| **Get Started Button** | Dark red rounded button → navigates to Auth Screen with fade transition |
| **Log In Link** | "Already have an account? Log in" → navigates to Auth Screen |

**Animations:** `SlideTransition` + `FadeTransition` on carousel text, `AnimatedContainer` on dot indicators, `Timer.periodic` auto-slide, smooth `PageRouteBuilder` fade transition to Auth.

---

### 2. 🔐 Auth Screen (`auth_screen.dart`)

Login and account creation screen with tabbed interface.

| Section | Description |
|---------|-------------|
| **Tab Switcher** | "Log In" / "Create Account" toggle with `AnimatedContainer` smooth background transition |
| **Name Field** | Appears/disappears with `AnimatedSize` when switching between login and signup |
| **Date of Birth** | Date picker field (signup only), opens native date picker |
| **Email Field** | Email input with hint text |
| **Password Field** | Obscured password input |
| **Forgot Password** | Link shown only on login tab |
| **Submit Button** | "Log In" or "Create Account" → navigates to Main Shell with smooth fade transition |
| **Social Login** | Google and Apple login buttons |
| **Entry Animation** | Entire form card slides up + fades in on screen load (600ms) |

**Animations:** `FadeTransition` + `SlideTransition` entry animation, `AnimatedContainer` tab switcher, `AnimatedSize` for name/DOB fields toggle, `PageRouteBuilder` fade transition to Main Shell.

---

### 3. 🏠 Home Screen (`home_screen.dart`)

The main dashboard showing daily stats, quick access cards, and an inspirational quote.

| Section | Description |
|---------|-------------|
| **Header** | "Good afternoon, Friend" greeting, mood emoji, date with moon phase, settings gear icon |
| **Stats Row** | 3 tappable stat cards: Day Streak (🔥 5), Min Today (🧘 24), Current Mood (💪) |
| **Quick Access Grid** | 4 gradient cards: Continue Meditation → Meditate tab, Today's Prompt → Journal tab, Daily Horoscope → Horoscope screen, Cycle Insight → Cycles tab |
| **Quote Banner** | Dark red gradient card: "Self-care is not selfish. You cannot serve from an empty vessel." |

**Interactive Modals (tapping stat cards):**

| Modal | Design |
|-------|--------|
| **🔥 Your Streak** | Header with emoji + title + X close button. Pink card with large "5" number, "Days in a row! 🎉". "📈 Keep going!" message. "Recent Activity" with 5 day cards (Today → 4 days ago) each with calendar icon, bold day name, "Completed 🔥". Bottom CTA button. |
| **🧘 Today's Sessions** | Header with emoji + title + X close button. Pink card with large "24", "Minutes of mindfulness today ☀️". "📈 36 min more than yesterday!". "Sessions Today" with 3 session cards: Morning Grounding (🌅, 10 min, 8:00 AM), Midday Reset (☀️, 5 min, 12:30 PM), Evening Wind Down (🌙, 9 min, 6:15 PM). "Start New Session" button. |
| **🌈 Select Your Mood** | Grid of 6 moods (Peaceful, Empowered, Romantic, Magical, Energized, Calm) with emojis. Tap to select and update home screen mood display. |

**Animations:** Staggered `FadeTransition` + `SlideTransition` on sections (stats → quick access → quote banner), `PageRouteBuilder` slide transition to Settings, fade+slide transition to Horoscope, `showModalBottomSheet` with rounded corners for modals.

---

### 4. ✨ Daily Horoscope Screen (`horoscope_screen.dart`)

Full astrology reading experience opened from the Home screen's "Daily Horoscope" card.

| Section | Description |
|---------|-------------|
| **Header** | Back arrow, "Daily Horoscope ✨" title, today's formatted date |
| **Select Your Sign** | 4×3 grid of 12 zodiac signs (Aries → Pisces) with colored circle icons, animated selection border + shadow |
| **Select Your Mood** | 6 mood chips (Peaceful, Empowered, Romantic, Magical, Energized, Calm) with animated selection border |
| **Reading Card** (appears after sign selection) | Sign name, date range, colored symbol icon. "Today's Reading" paragraph. Three category sections with circle icons: ❤️ Love & Relationships, 💼 Career & Finance, ✨ Wellness. Footer row: Lucky Number, Lucky Color, Your Mood (if selected). |
| **Quote Banner** | Dark red gradient card with 🌙 moon icon and zodiac-inspired quote |
| **Bottom Navigation** | Full 5-tab bottom nav bar matching Main Shell, tapping any tab pops screen and navigates to that tab |

**Data:** 12 unique zodiac readings with personalized content for each sign. 6 rotating inspirational quotes.

**Animations:** `AnimatedContainer` on sign/mood selection, `FadeTransition` + `SlideTransition` on reading card appearance (500ms), fade on quote banner.

---

### 5. 🧘 Meditate Screen (`meditate_screen.dart`)

Meditation library with full in-session experience.

| Section | Description |
|---------|-------------|
| **Category Filters** | Scrollable chips: All, Morning, Stress, Sleep, Focus, Evening |
| **Search Bar** | Search field for meditation names |
| **Meditation Cards** | List of 7 meditation sessions with emoji, title, duration, difficulty tag, "Start" button |

**Active Meditation Session (when "Start" is tapped):**

| Section | Description |
|---------|-------------|
| **Background** | Full-screen dark red gradient |
| **Timer Circle** | Large circular timer with breathing pulse animation (scale 0→0.05, 600ms sine wave) |
| **Breathing Guide** | Cycling text: "Breathe..." → "Inhale..." → "Exhale..." → "Relax..." |
| **Progress Bar** | Animated fill showing session progress |
| **Pause/Resume** | Toggle button to pause/resume timer and breathing animation |
| **End Session** | Returns to library with `AnimatedSwitcher` fade transition (400ms) |

**Animations:** `AnimatedSwitcher` between library and session views, `Transform.scale` breathing animation with `TweenSequence`, `Timer.periodic` countdown, smooth progress bar fill.

---

### 6. 📓 Journal Screen (`journal_screen.dart`)

Comprehensive journaling experience with prompts, free writing, and progress tracking.

| Section | Description |
|---------|-------------|
| **Today's Prompt** | Card showing daily writing prompt with "Start Writing" button |
| **Writing Cards** | 5 collapsible sections with `AnimatedSize` transitions: |

**Expandable Sections:**

| Section | Content |
|---------|---------|
| **📝 Browse Prompts** | Animated panel with 10 writing prompts. Tap to select a prompt (highlighted), closes panel. |
| **✍️ Free Writing** | Large text area for freeform journaling with "Save Entry" button → adds to Past Entries |
| **📊 Daily Summary** | Gratitude, mood, accomplishment, and goal fields with "Save Summary" button |
| **✅ To-Do List** | Add/check/delete to-do items with text input and interactive checkboxes |
| **📈 My Progress** | Wellness journey stats grid (Journal Entries, Meditation Minutes, Cycles Tracked, Mood Boards), streak banner (current + best streak), weekly activity bar chart, achievements grid (8 badges, 3 locked). |

| Bottom Sections | Description |
|---------|-------------|
| **"Progress, not perfection"** | Motivational card with 🎯 icon and encouragement text |
| **Past Entries** | List of saved journal entries with date, prompt title, preview text, and ❤️ favorite icon |
| **Voltaire Quote** | Pink gradient card: *"Writing is the painting of the voice." — Voltaire* |

**Animations:** `AnimatedSize` (300ms, easeInOut) on all 5 expandable sections for smooth open/close.

---

### 7. 🌙 Cycles Screen (`cycles_screen.dart`)

Menstrual cycle tracker with detailed phase information and interactive popups.

| Section | Description |
|---------|-------------|
| **Current Phase Card** | Gradient card showing: phase name (Follicular), cycle day (Day 12), days until next period, circular indicator |
| **Action Buttons** | "Edit Cycle" and "Log Today" buttons |
| **Next Period Card** | Tappable card showing next period date → opens Cycle Predictions popup |
| **Cycle Phases Timeline** | 4 phase cards: Menstrual (Days 1-5), Follicular (Days 6-13), Ovulation (Days 14-16), Luteal (Days 17-28) |
| **Phase Insights Card** | Current phase details: Energy Level, Nutrition Focus, Recommended Activities |
| **Moon Phase Sync** | Dark red gradient card with vibrating 🌕 moon icon, moon phase info, "Learn More" button |

**Interactive Popups (using `showGeneralDialog`):**

| Popup | Content |
|-------|---------|
| **Edit Cycle Info** | Scale+fade animation. Fields: Last Period Start Date (date picker), Average Cycle Length, Average Period Length. "Save Changes" button. |
| **Log Today** | Slide-up+fade animation. `_LogTodayDialog` StatefulWidget. Date picker, Flow selector (None/Light/Medium/Heavy toggle with animated highlight), Symptoms grid (10 symptoms with circle checkboxes). "Save Log" button. |
| **Cycle Predictions** | Scale+fade animation. Next Period card (pink background, date, "In X days"), Ovulation Window card (yellow background), medical disclaimer. |

**Animations:** Moon icon continuous shake via `TweenSequence` (-6px → +6px → -4px → +4px → center, 600ms repeating), `showGeneralDialog` with `ScaleTransition` + `FadeTransition` for Edit/Predictions, `SlideTransition` for Log Today.

---

### 8. 😊 Mood Screen (`mood_screen.dart`)

AI-powered mood board generator with visual inspiration.

| Section | Description |
|---------|-------------|
| **Mood Selector Card** | "How are you feeling?" with 3×2 grid of 6 moods (Peaceful 😌, Empowered 💪, Romantic 🌸, Magical ✨, Energized 🔥, Calm 🌊), animated selection border. "Generate Mood Board" button. |
| **Mood Detail Card** | Emoji + title (e.g., "Empowered Energy"), subtitle, inspirational quote in styled container, Benefits list (3 items), Try activities list (3 items). |
| **Saved Boards** | Counter showing total saved boards (starts at 7), "View history" link |
| **Journal It** | Card encouraging reflection: "Reflect on your mood and save insights to your journal" |
| **Your [Mood] Board** | Title with refresh button (🔄). Grid of 4 visual mood cards with gradient backgrounds, themed emojis, and descriptive titles. Each mood has 2-3 board variants. |
| **Save Collection Banner** | Pink gradient card: "Love your mood board? Save it to your collection!" with "Save Collection" button → increments saved count + snackbar confirmation. |

**Board Image Data:** Each mood has 2-3 visual board variants with 4 cards each. Examples:
- **Peaceful:** Forest Serenity 🌿, Still Waters 💧, Lotus Garden 🪷, Golden Hour 🌅
- **Empowered:** Inner Lion 🦁, Lightning Power ⚡, Mountain Top 🏔️, Diamond Will 💎
- **Energized:** Thunder Bolt ⚡, Flame On 🔥, Power Burst 💥, Full Sprint 🏃

**Animations:** `FadeTransition` + `SlideTransition` on mood detail card (500ms), `FadeTransition` on board grid (400ms), `TweenAnimationBuilder` staggered scale+fade on individual board image cards (300-600ms), reverse+forward fade on board refresh, `AnimatedContainer` on mood selection, `AnimatedRotation` on refresh icon.

---

### 9. ⚙️ Settings Screen (`settings_screen.dart`)

App configuration with profile, preferences, and account management.

| Section | Description |
|---------|-------------|
| **Header** | Back arrow + "Settings" title |
| **Profile Card** | Avatar circle (initial "F"), name "Friend", plan "Free Plan", "Edit" button, stats row (Day Streak, Sessions, Journals) |
| **Account Section** | Profile, Privacy, Notifications toggle, Dark Mode toggle (functional with `ThemeNotifier`) |
| **Subscription** | Theta Premium "Upgrade" badge, Billing management |
| **Support** | Help Center |
| **Log Out** | Destructive-styled button → navigates to Splash Screen with fade transition, clears navigation stack |
| **Footer** | App version "Theta v1.0.0", "Made with 💜 for your wellness journey" |

**Animations:** Smooth `SlideTransition` from right when entering (triggered from Home), `PageRouteBuilder` fade transition on logout.

---

## 🎨 Design System

| Element | Details |
|---------|---------|
| **Primary Color** | `#8B0000` (Dark Red / Maroon) |
| **Light Background** | `#F5E6E0` (Warm Peach) |
| **Card Background** | `#FAF0EB` (Soft Cream) |
| **Accent Pink** | `#F4C2C2` (Rose Pink) |
| **Dark Background** | `#1A0A08` (Deep Espresso) |
| **Dark Card** | `#2C1810` (Dark Walnut) |
| **Heading Font** | Playfair Display (Serif) |
| **Body Font** | DM Sans (Sans-serif) |
| **Dark Mode** | Full dark mode support across all screens via `ThemeNotifier` |

---

## 🛠️ Technology Stack

| Technology | Purpose |
|------------|---------|
| **Flutter 3.11+** | Cross-platform UI framework |
| **Dart 3.11+** | Programming language |
| **Material Design 3** | UI component system |
| **Google Fonts** (`google_fonts: ^8.0.2`) | Playfair Display & DM Sans typography |
| **intl** (`intl: ^0.20.2`) | Date formatting (`DateFormat`) |
| **Cupertino Icons** (`cupertino_icons: ^1.0.8`) | iOS-style icons |

### Architecture
- **State Management:** Local `StatefulWidget` with `setState` pattern
- **Theme:** `ThemeNotifier` (ChangeNotifier) with `ThemeNotifierProvider` (InheritedWidget)
- **Navigation:** `Navigator` with `MaterialPageRoute` and `PageRouteBuilder` for custom transitions
- **Animations:** Built-in Flutter animation system — `AnimationController`, `FadeTransition`, `SlideTransition`, `ScaleTransition`, `AnimatedContainer`, `AnimatedSize`, `TweenSequence`, `AnimatedSwitcher`, `AnimatedBuilder`

---

## 🚀 How to Run This Project

### Prerequisites

Before running this project, you need to install:

1. **Flutter SDK**
2. **Dart SDK** (included with Flutter)
3. **A code editor** (VS Code recommended)
4. **Platform-specific tools** (details below per OS)

---

### 🪟 Windows Setup (Step by Step)

#### Step 1: Install Git
1. Download Git from [https://git-scm.com/download/win](https://git-scm.com/download/win)
2. Run the installer with default settings
3. Open **Command Prompt** and verify:
   ```
   git --version
   ```

#### Step 2: Install Flutter SDK
1. Download Flutter SDK from [https://docs.flutter.dev/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows)
2. Extract the zip file to `C:\flutter` (or your preferred location)
3. Add Flutter to your PATH:
   - Open **Start** → Search **"Environment Variables"** → Click **"Edit the system environment variables"**
   - Click **"Environment Variables"** → Under **"User variables"**, find **"Path"** → Click **"Edit"**
   - Click **"New"** → Add `C:\flutter\bin`
   - Click **OK** on all dialogs
4. Open a **new** Command Prompt and verify:
   ```
   flutter --version
   ```

#### Step 3: Install Android Studio (for Android development)
1. Download from [https://developer.android.com/studio](https://developer.android.com/studio)
2. Run the installer → Select **"Android SDK"**, **"Android SDK Platform"**, and **"Android Virtual Device"**
3. Open Android Studio → Go to **File → Settings → Appearance & Behavior → System Settings → Android SDK**
4. Go to **SDK Tools** tab → Check **"Android SDK Command-line Tools"** → Click **Apply**
5. Accept Android licenses:
   ```
   flutter doctor --android-licenses
   ```

#### Step 4: Install VS Code (Recommended Editor)
1. Download from [https://code.visualstudio.com](https://code.visualstudio.com)
2. Install the **Flutter** extension (by Dart Code) from the Extensions marketplace
3. Install the **Dart** extension

#### Step 5: Verify Installation
```
flutter doctor
```
Fix any issues the doctor reports. All checkmarks should be green ✅.

#### Step 6: Clone and Run the Project
```bash
git clone <repository-url>
cd "theta app"
flutter pub get
flutter run
```

To run on a specific device:
```bash
# List available devices
flutter devices

# Run on Chrome (web)
flutter run -d chrome

# Run on a connected Android phone
flutter run -d <device-id>

# Run on Windows desktop
flutter run -d windows
```

---

### 🐧 Linux Setup (Step by Step)

#### Step 1: Install Required Dependencies
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y curl git unzip xz-utils zip libglu1-mesa
sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev
```

#### Step 2: Install Flutter SDK
```bash
# Download Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.bashrc or ~/.zshrc for permanent)
export PATH="$HOME/flutter/bin:$PATH"

# Apply changes
source ~/.bashrc   # or source ~/.zshrc

# Verify
flutter --version
```

#### Step 3: Install Android Studio (for Android Development)
1. Download from [https://developer.android.com/studio](https://developer.android.com/studio)
2. Extract and run:
   ```bash
   tar -xzf android-studio-*.tar.gz
   cd android-studio/bin
   ./studio.sh
   ```
3. Follow the setup wizard → Install Android SDK
4. Install command-line tools: **SDK Manager → SDK Tools → Android SDK Command-line Tools**
5. Accept licenses:
   ```bash
   flutter doctor --android-licenses
   ```

#### Step 4: Install VS Code
```bash
# Ubuntu/Debian
sudo snap install code --classic
```
Then install **Flutter** and **Dart** extensions.

#### Step 5: Install Chrome (for Web Development)
```bash
# Ubuntu/Debian
sudo apt install -y google-chrome-stable
# Or download from https://www.google.com/chrome/
```

#### Step 6: Verify Installation
```bash
flutter doctor
```

#### Step 7: Clone and Run
```bash
git clone <repository-url>
cd "theta app"
flutter pub get

# Run on Linux desktop
flutter run -d linux

# Run on Chrome
flutter run -d chrome
```

---

### 🍎 macOS Setup (Step by Step)

#### Step 1: Install Xcode (Required for iOS)
1. Open **App Store** → Search **"Xcode"** → Install
2. After installation, open Terminal:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```
3. Accept the Xcode license:
   ```bash
   sudo xcodebuild -license accept
   ```

#### Step 2: Install Homebrew (Package Manager)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Step 3: Install CocoaPods (Required for iOS)
```bash
sudo gem install cocoapods
```

#### Step 4: Install Flutter SDK
```bash
# Using Homebrew (easiest)
brew install flutter

# Verify
flutter --version
```

Or manually:
```bash
cd ~
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$HOME/flutter/bin:$PATH"
# Add the export line to ~/.zshrc for permanent PATH
```

#### Step 5: Install Android Studio (for Android Development)
1. Download from [https://developer.android.com/studio](https://developer.android.com/studio)
2. Drag to Applications folder
3. Open → Follow setup wizard → Install Android SDK
4. Accept licenses:
   ```bash
   flutter doctor --android-licenses
   ```

#### Step 6: Install VS Code
```bash
brew install --cask visual-studio-code
```
Install **Flutter** and **Dart** extensions.

#### Step 7: Verify Installation
```bash
flutter doctor
```

#### Step 8: Clone and Run
```bash
git clone <repository-url>
cd "theta app"
flutter pub get

# Run on iOS Simulator
open -a Simulator
flutter run

# Run on macOS desktop
flutter run -d macos

# Run on Chrome
flutter run -d chrome

# Run on connected iPhone
flutter run -d <device-id>
```

---

## 📂 Project Structure

```
theta_app/
├── lib/
│   ├── main.dart                    # App entry point, theme setup
│   ├── screens/
│   │   ├── splash_screen.dart       # Animated splash with text carousel
│   │   ├── auth_screen.dart         # Login/signup with animated form
│   │   ├── main_shell.dart          # Bottom navigation shell (5 tabs)
│   │   ├── home_screen.dart         # Dashboard with stats & quick access
│   │   ├── horoscope_screen.dart    # Daily zodiac readings
│   │   ├── meditate_screen.dart     # Meditation library & sessions
│   │   ├── journal_screen.dart      # Journaling with prompts & progress
│   │   ├── cycles_screen.dart       # Menstrual cycle tracker
│   │   ├── mood_screen.dart         # AI mood board generator
│   │   └── settings_screen.dart     # App settings & profile
│   └── theme/
│       ├── app_colors.dart          # Color palette (light + dark)
│       ├── app_theme.dart           # Material theme configuration
│       └── theme_notifier.dart      # Dark mode state management
├── android/                         # Android platform files
├── ios/                             # iOS platform files
├── linux/                           # Linux platform files
├── macos/                           # macOS platform files
├── web/                             # Web platform files
├── windows/                         # Windows platform files
├── test/                            # Unit & widget tests
├── pubspec.yaml                     # Dependencies & configuration
└── README.md                        # This file
```

---

## 🎬 Animations Summary

| Animation Type | Where Used |
|---------------|------------|
| **Page Transitions** | Fade (Splash→Auth, Auth→Shell, Logout→Splash), Slide-right (Home→Settings), Fade+Slide (Home→Horoscope) |
| **Tab Transitions** | `AnimatedSwitcher` with fade+slide in Main Shell |
| **Text Carousel** | `SlideTransition` + `FadeTransition` in Splash Screen |
| **Entry Stagger** | Fade+slide on Home screen sections (stats → cards → quote) |
| **Form Animations** | `AnimatedSize` on Auth name fields, `AnimatedContainer` on tab switcher |
| **Section Expand** | `AnimatedSize` on all 5 Journal collapsible sections |
| **Selection States** | `AnimatedContainer` on mood/zodiac selection in Horoscope & Mood screens |
| **Breathing Pulse** | `TweenSequence` scale animation in Meditation session |
| **Moon Shake** | `TweenSequence` horizontal vibration in Cycles screen |
| **Board Refresh** | Reverse+forward fade on Mood board image swap |
| **Board Cards** | `TweenAnimationBuilder` staggered scale+fade on individual cards |
| **Dialog Entry** | `ScaleTransition` + `FadeTransition` for Cycle dialogs |
| **Modal Sheets** | Slide-up bottom sheets for Home stats, Mood selector |

---

## 📄 License

This project is private and not published to pub.dev.

---

<p align="center">
  Made with 💜 for your wellness journey
</p>
