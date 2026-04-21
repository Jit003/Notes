# 🤖 AI Prompt Log

## 1) Prompt:

How to design an offline-first architecture in Flutter?

**Summary:** Suggested local-first approach with sync mechanism
**Decision:** Accepted (Modified)
**Why:** Adapted to Hive + Firebase with custom queue for better control

---

## 2) Prompt:

How to implement offline queue for API calls?

**Summary:** Store pending actions locally with retry
**Decision:** Accepted
**Why:** Matches assignment requirements

---

## 3) Prompt:

How to avoid duplicate API calls?

**Summary:** Use idempotency keys
**Decision:** Accepted
**Why:** Used note ID with Firestore `.doc(id).set()`

---

## 4) Prompt:

Why UI not updating after local save?

**Summary:** Use optimistic UI update
**Decision:** Accepted
**Why:** Improved responsiveness

---

## 5) Prompt:

How to implement retry logic?

**Summary:** Retry with delay and limit
**Decision:** Accepted (Modified)
**Why:** Implemented single retry to avoid infinite loops

---

## 🧠 Reflection

AI was used for guidance and problem-solving, but all solutions were reviewed, modified, and tested manually.
