const { auth } = require("./firebase");
const jwt = require('jsonwebtoken');
const gateway = require("fast-gateway");

const port = 3000;

var _token = '';

function generateToken(uid) {
    const secretKey = 'privateKeyCrom@1965879'; // Esta es la clave secreta que se utiliza para firmar el token
    const payload = {
        sub: '3.14',
        name: 'iam',
        role: 'gateway',
        uid: uid
    };

    const options = {
        algorithm: 'HS256',
        expiresIn: '1h'
    };

    var token = jwt.sign(payload, secretKey, options);

    _token = token;
}



const server = gateway({

    middlewares: [

        (req, res, next) => {
            console.log(req.originalUrl)

            if (req.originalUrl == '/healt' || req.originalUrl == '/register/Register' ) {
                return next()
            } else {
                if (!req.headers.authorization)
                    return res.send({ message: "Tu petición no tiene cabecera de autorización" })

                var token = req.headers.authorization.split(" ")[1];

                auth.verifyIdToken(token)
                    .then((decodedToken) => { 
                        generateToken(decodedToken.uid)
                        return next() })
                    .catch((error) => {
                        res.send({ message: "El token ha expirado" }, 200)
                    });
            }
        }

    ],

    routes: [
        {
            prefix: "/register",
            target: "http://localhost:7244",
        },
        {
            prefix: "/user",
            target: "http://localhost:7244",
            hooks: {
                rewriteRequestHeaders(req, headers) {
                    headers['Content-Type'] = 'application/json';
                    console.log(_token)
                    headers['Authorization'] = 'Bearer ' + _token;
                    return headers
                }
            }
        },
        {
            prefix: "/payment",
            target: "http://localhost:9002/",
            hooks: {}
        }
    ]
});

server.get('/healt', (req, res) => {
    res.send({
        'status': 200,
        'msg': "ok"
    });
})

server.start(port).then(server => {
    console.log("Gateway is running " + port);
})