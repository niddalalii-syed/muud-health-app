## 📱 Features

- 📝 **Journal Entry**
  - Log your mood with emojis
  - Write free-form daily reflections
  - See your recent entries at a glance

- 📊 **History**
  - View past journal entries with mood indicators
  - Clean, scrollable listing with timestamped entries

- 📇 **Emergency Contacts**
  - Add trusted individuals to contact during distress
  - Modern card layout with easy data input

- 🔐 **Authentication**
  - Secure login and signup system
  - Token-based session persistence using Shared Preferences

- 🚪 **Logout**
  - Global confirmation popup
  - Clears user session and local storage

- 🌈 **Responsive UI**
  - Professionally styled
  - Works great on both Android and iOS

---

## 🧱 Tech Stack

- Flutter 3.29.2
- Provider + Bloc (Auth State)
- REST API Integration (Custom backend)
- SharedPreferences for session persistence


## 📁 Folder Structure

```
lib/
├── api/               # REST API services
├── auth/              # Login & Signup screens
├── bloc/              # AuthBloc and states
├── model/             # Data models
├── core/              # Constants
├── tabs/              # Journal, History, Contacts screens
├── widgets/           # Reusable components (dialogs, snackbar)
├── Splash_screen.dart # Splash Screen
├── main.dart          # Entry point
```

---

## 🔐 Authentication API Contract

- **POST** `/auth/login` → Logs in user
- **POST** `/auth/signup` → Registers new user
- **GET** `/journal/entries` → Fetch user journal entries
- **POST** `/journal/entry` → Submit a new journal entry
- **GET** `/contacts/user/{userId}` → Fetch user’s emergency contacts
- **POST** `/contacts/add` → Add new contact

#Note : Replace URL with the local host URL you setup for the Api
1. Fork the repository
2. Create your feature branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature-name`)
5. Open a Pull Request
