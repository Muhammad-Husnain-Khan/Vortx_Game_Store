// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth } from "firebase/auth";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyC9AvIqLBHOxf1OU2RIFWZplQH4XwSClME",
  authDomain: "vortxgamestore.firebaseapp.com",
  projectId: "vortxgamestore",
  storageBucket: "vortxgamestore.firebasestorage.app",
  messagingSenderId: "951136183046",
  appId: "1:951136183046:web:9f8a7da7cce6e86004b487",
  measurementId: "G-7ZVZXYS2GY"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
const auth = getAuth(app);

export { app,auth };    