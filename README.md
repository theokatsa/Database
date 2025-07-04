# Database
Databases project for 3rd year of Computer Engineering and Informatics Department of University of Patras

# Εργασία Βάσεων Δεδομένων – eRecruit2023

Αυτή η εργασία πραγματοποιήθηκε στο πλαίσιο του μαθήματος **Βάσεις Δεδομένων** και αφορά την υλοποίηση ενός συστήματος διαχείρισης αιτήσεων για θέσεις εργασίας (e-recruitment system), με χρήση **MySQL** και προχωρημένων εννοιών SQL όπως:

- **Stored Procedures**
- **Triggers**
- **Σχέσεις πολλαπλών πινάκων**
- **Indexes**
- **Ασφαλή χειρισμό δεδομένων και συναρτήσεων**

## 🏗️ Βασικά Χαρακτηριστικά

- Δημιουργία σχεσιακής βάσης `erecruit2023` με πλήθος πινάκων όπως `employee`, `job`, `application_details`, `evaluation_assignments` κ.ά.
- Υλοποίηση trigger-μηχανισμών για:
  - Έλεγχο εγκυρότητας αιτήσεων
  - Καταγραφή ενεργειών admin σε πίνακα `dba_log`
- Stored Procedures για:
  - Αξιολόγηση αιτήσεων (`evaluate_promotion`)
  - Ανάθεση θέσεων (`fill_job_position`)
  - Διαχείριση ενεργών/ακυρωμένων αιτήσεων (`ManageApplication`)
- Εισαγωγή 60.000 εγγραφών με χρήση `LOOP` και `BATCHS`
- Αναζήτηση αιτήσεων μέσω indexes για βελτιωμένη απόδοση

## 👥 Συμμετέχοντες

- **Θεόδωρος Κατσάντας** – ΑΜ: 1097459  
- **Αγγελική Δούβρη** – ΑΜ: 1097441  

3ο Έτος | Τμήμα Μηχανικών Η/Υ & Πληροφορικής, Πανεπιστήμιο Πατρών

## 💻 Τεχνολογίες

- MySQL 8.0+
- SQL Procedures & Triggers
- PhpMyAdmin / MySQL Workbench (προτεινόμενο για δοκιμές)

---


