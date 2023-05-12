//process.env.GOOGLE_APPLICATION_CREDENTIALS = '/usr/src/app/firebase.json';
process.env.GOOGLE_APPLICATION_CREDENTIALS = 'C:/workspace/ADGE/iam/firebase.json';


const { initializeApp, applicationDefault } = require('firebase-admin/app')
const { getAuth } = require('firebase-admin/auth');

initializeApp({
    credential:applicationDefault()
})

const auth = getAuth();

module.exports = {
    auth
}