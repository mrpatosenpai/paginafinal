const express = require('express');
const mysql = require('mysql');
const { insertar, verificar, recuperarContrasena, insertarVisita } = require('./solicitudes');
const path = require('path');

const app = express(); // Renombrar la variable a 'app'

const conex = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "manzanas_cuidado"
});

conex.connect((err) => {
    if (err) throw err;
    console.log("Todo en orden");
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(express.static(path.join(__dirname, 'public')));

app.post('/insertar', (req, res) => {
    const { tipo_documento, numero_documento, contraseña, nombre, apellidos, telefono, correo, ciudad, direccion } = req.body;

    insertar(conex, { tipo_documento, numero_documento, contraseña, nombre, apellidos, telefono, correo, ciudad, direccion }, (result) => {
        if (result !== false) {
            res.redirect('/pcontraseña.html');
        } else {
            res.send('<script>alert("No se pudo registrar el usuario"); window.location="/registromujeres.html";</script>');
        }
    });
});
app.post('/verificar', (req, res) => {
    const { numero_documento, contraseña } = req.body;
    console.log('Número de documento recibido:', numero_documento);
    console.log('Contraseña recibida:', contraseña);
    verificar(conex, numero_documento, contraseña, (result) => {
        if (result.length > 0) {
            res.redirect('/index.html');
        } else {
            res.send('<script>alert("Credenciales incorrectas"); window.location="/pcontraseña.html";</script>');
        }
    });
});
app.get('/recuperarContrasena', (req, res) => {
    const { tipo_documento, numero_documento, contraseña } = req.body;

    recuperarContrasena(conex, tipo_documento, numero_documento, contraseña, (result) => {
        if (result !== false) {
            res.redirect('/pcontraseña.html');
        } else {
            res.send('<script>alert("Credenciales incorrectas"); window.location="/recuperar.html";</script>');
        }
    });
});
app.post('/insertarVisita', (req, res) => {
    const { manzana_visita, fecha_hora_visita, servicio_solicitado, fecha_visita } = req.body;

    insertarVisita(conex, { manzana_visita, fecha_hora_visita, servicio_solicitado, fecha_visita }, (result) => {
        if (result !== false) {
            res.send('<script>alert("Visita agendada con exito :)"); window.location="/formulario.html";</script>');
        } else {
            res.send('<script>alert("No se pudo agendar la visita"); window.location="/formulario.html";</script>');
        }
    });
});
app.post('/eliminarVisita', (req, res) => {
    const idVisita = req.params.id;
    eliminarVisita(conex, idVisita, (eliminado) => {
        if (eliminado) {
            res.send('<script>alert("Visita eliminada correctamente"); window.location="/formulario.html";</script>');
        } else {
            res.send('<script>alert("No se pudo eliminar la visita"); window.location="/formulario.html";</script>');
        }
    });
});
app.listen(3000, () => {
    console.log("Funcionando en el puerto 3000");
}); 