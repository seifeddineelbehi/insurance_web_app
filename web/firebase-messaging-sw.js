
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;
const firebaseConfig = {
  apiKey: "AIzaSyBGdyWfYIqg0iAx3kGIjQkkue1OQ3LLvhk",
  authDomain: "insurancewebapp-7d311.firebaseapp.com",
  projectId: "insurancewebapp-7d311",
  storageBucket: "insurancewebapp-7d311.appspot.com",
  messagingSenderId: "328779793810",
  appId: "1:328779793810:web:55f80444ed831e956aad4b",
  measurementId: "G-Y6Y3FF6CFT"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();
// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});
