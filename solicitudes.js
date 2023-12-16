const mysql = require('mysql');
const conexion = require('./conexion');

function insertar(conex, data, callback) {
    let insertQ = "INSERT INTO usuario (tipo_documento,numero_documento,contraseña,nombre,apellidos,telefono,correo,ciudad,direccion) VALUES(?,?,?,?,?,?,?,?,?)";
    let query = mysql.format(insertQ, [data.tipo_documento, data.numero_documento, data.contraseña, data.nombre, data.apellidos, data.telefono, data.correo, data.ciudad, data.direccion]);

    conex.query(query, function(err, result) {
        if (err) {
            console.error(err);
            callback(false); 
        } else {
            callback(result); 
        }
    });
}
function verificar(conex, numero_documento, contraseña, callback) {
  
    if (numero_documento !== undefined && contraseña !== undefined && contraseña !== null) {
        let selectQ = "SELECT * FROM usuario WHERE numero_documento = ? AND contraseña = ?";
        let query = mysql.format(selectQ, [numero_documento, contraseña]);

        conex.query(query, function(err, result) {
            if (err) {
                console.error(err);
                callback(false); 
            } else {
                if (result.length > 0) {
                    callback(result); 
                } else {
                    callback(false); 
                }
            }
        });
    } else {
        callback(false); 
    }
}
function recuperarContrasena(conex, tipo_documento, numero_documento, nueva_contraseña, callback) {
    if (tipo_documento !== undefined && numero_documento !== undefined && nueva_contraseña !== undefined) {
        let updateQ = "UPDATE usuario SET contraseña = ? WHERE tipo_documento = ? AND numero_documento = ?";
        let query = mysql.format(updateQ, [contraseña, tipo_documento, numero_documento]);

        conex.query(query, function(err, result) {
            if (err) {
                console.error(err);
                callback(false); 
            } else {
                if (result.affectedRows > 0) {
                    callback(result); 
                } else {
                    callback(false); 
                }
            }
        });
    } else {
        callback(false);
    }
}
function insertarVisita(conex, data, callback) {
    let insertQ = "INSERT INTO visitas (manzana_visita, fecha_hora_visita, servicio_solicitado, fecha_visita) VALUES(?,?,?,?)";
    let query = mysql.format(insertQ, [data.manzana_visita, data.fecha_hora_visita, data.servicio_solicitado, data.fecha_visita]);

    conex.query(query, function(err, result) {
        if (err) {
            console.error(err);
            callback(false); 
        } else {
            callback(result); 
        }
    });
}
function eliminarVisita(conex, idVisita, callback) {
    let deleteQ = "DELETE FROM visitas WHERE id_visita = ?";
    let query = mysql.format(deleteQ, [idVisita]);

    conex.query(query, function(err, result) {
        if (err) {
            console.error(err);
            callback(false);
        } else {
            callback(result.affectedRows > 0); 
        }
    });
}
module.exports = { insertar, verificar, recuperarContrasena, insertarVisita, eliminarVisita};
