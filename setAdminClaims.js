const admin = require('firebase-admin');
const serviceAccount = require('D:/Kuliah/SMT 3/Pemrograman Mobile/Flutter/Project1/coffee/coffeeshop-5f771-firebase-adminsdk-rwx12-19754c5230.json');
// Inisialisasi Firebase Admin SDK
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    projectId: 'coffeeshop-5f771', // Ganti dengan ID proyek Anda di Firebase
  });
  

async function setAdminRole(uid) {
  try {
    await admin.auth().setCustomUserClaims(uid, { admin: true });
    console.log(`Custom claims admin telah berhasil ditambahkan ke pengguna dengan UID: ${uid}`);
  } catch (error) {
    console.error("Error saat menetapkan custom claims:", error);
  }
}

// Ganti 'UID_ADMIN' dengan UID sebenarnya dari akun yang akan diberi role admin
setAdminRole('wUeZKj0KaXVb0cCMNLRBvSeaB8u2');
