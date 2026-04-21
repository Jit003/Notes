<<<<<<< HEAD
# 📱 Offline Notes App (Flutter)

## 📌 Overview

This project is a simple notes application built with Flutter that follows an **offline-first architecture**. The main goal is to ensure that users can read and write data even without an internet connection, and the app will automatically sync data with the server when connectivity is restored.

---

## 🚀 Features

* ✅ Local-first data loading (instant UI)
* ✅ Offline note creation
* ✅ Persistent sync queue (stored in Hive)
* ✅ Automatic sync when internet is available
* ✅ Retry mechanism for failed requests
* ✅ Idempotency (no duplicate data on retry)
* ✅ Logs for sync tracking and debugging

---

## 🧠 Approach

### 1. Local-first strategy

All data is stored and read from the local database (Hive).
When the app starts:

* Notes are loaded instantly from local storage
* A background API call fetches fresh data from Firebase
* Local DB is updated and UI reflects changes

---

### 2. Offline write handling

When the user adds a note:

* The note is immediately saved in the local database
* UI updates instantly (no waiting for API)
* If offline → the action is added to a sync queue

---

### 3. Sync Queue

A persistent queue is maintained using Hive.

Each queue item contains:

* id (used as idempotency key)
* type (e.g., add_note)
* payload (note data)
* retryCount

When internet is available:

* The queue is processed
* API is called for each item
* On success → item is removed
* On failure → retried once

---

### 4. Idempotency

Each note uses a unique ID.

While syncing:

* Firebase uses `.doc(id).set()`
* This ensures retries do not create duplicates

---

### 5. Conflict Strategy

I used **Last Write Wins**:

* Latest update replaces older data
* Simple and effective for this use case

---

## 🏗️ Architecture

The project follows a clean structure:

* **Presentation Layer** → UI + Riverpod state management
* **Data Layer** → Local (Hive) + Remote (Firebase)
* **Core Services** → Sync service, connectivity listener

The repository acts as a bridge between local and remote sources.

---

## 📦 Tech Stack

* Flutter
* Riverpod (State Management)
* Hive (Local Database)
* Firebase Firestore (Backend)
* Connectivity Plus

---

## 🔄 Data Flow

### Read Flow

1. Load from local DB
2. Fetch from API (background)
3. Update local DB
4. UI refresh

---

### Write Flow

**Online:**

* Save to local DB
* Send to Firebase

**Offline:**

* Save to local DB
* Add to queue

**When internet returns:**

* Queue processed
* Data synced to Firebase

---

## 🧪 Verification

### ✅ Scenario 1: Offline Add Note

* Turn off internet
* Add note
* Note appears instantly
* Queue size increases

---

### ✅ Scenario 2: Auto Sync

* Turn internet on
* Queue is processed
* Note appears in Firebase
* Queue becomes empty

---

### ✅ Scenario 3: Retry

* Simulated API failure
* Retry executed once
* No duplicate data created

---

## 📊 Logs

Example logs:

```
[SYNC] Queue size: 1
[SYNC] Success: note_id
[SYNC] Failed: retrying...
```

---

## ⚠️ Tradeoffs & Limitations

* Basic retry (only once, no exponential backoff)
* Conflict handling is simple (last-write-wins only)
* No background sync service when app is terminated
* No pagination for large datasets

---

## 🔮 Future Improvements

* Add exponential backoff retry
* Background sync using isolates/workmanager
* Better conflict resolution (merge strategy)
* Add TTL for cached data
* Unit testing for queue and idempotency

---

## 🤖 AI Usage (Summary)

AI was used for:

* Structuring architecture
* Designing sync queue
* Improving code clarity

All responses were reviewed, modified, and tested manually before implementation.

---

## 📁 How to Run

1. Clone the repo
2. Run `flutter pub get`
3. Setup Firebase (`google-services.json`)
4. Run the app

---

## 👨‍💻 Final Note

This project focuses on **real-world offline-first challenges**, including data consistency, reliability, and user experience. The goal was to build something close to production thinking rather than just a basic CRUD app.

---
=======
# Notes
Built a Flutter offline-first notes app using Hive for local storage and Firebase for backend. Supports offline add/delete with a sync queue, retry logic, and idempotency. Ensures instant UI updates, smooth UX, and reliable data syncing when connectivity returns.
>>>>>>> 3f7f7922330f08654edfde105a97f9af7c3b3fc8
