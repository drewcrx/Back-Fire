import express from "express";
import bcrypt from "bcrypt";
import { pool } from "../db/connection.js";
const router = express.Router();

// Registro
router.post("/register", async (req, res) => {
  const { nombre, correo, usuario, password } = req.body || {};
  if (!nombre || !correo || !usuario || !password) {
    return res.status(400).json({ error: "Completa todos los campos" });
  }
  try {
    const existeUser = await pool.query(
      "SELECT 1 FROM usuarios WHERE usuario = $1",
      [usuario]
    );
    const existeCorreo = await pool.query(
      "SELECT 1 FROM usuarios WHERE correo = $1",
      [correo]
    );
    if (existeUser.rowCount > 0) {
      return res.status(409).json({ error: "El usuario ya existe" });
    }
    if (existeCorreo.rowCount > 0) {
      return res.status(409).json({ error: "El correo ya está registrado" });
    }
    const hash = await bcrypt.hash(password, 10);
    await pool.query(
      `INSERT INTO usuarios (nombre, correo, usuario, password_hash) VALUES ($1, $2, $3, $4)`,
      [nombre, correo, usuario, hash]
    );
    return res.json({ mensaje: "Usuario registrado correctamente" });
  } catch (error) {
    return res.status(500).json({ error: "Error en el registro", detalle: error.message });
  }
});

// Login 
router.post("/login", async (req, res) => {
  const { usuario, correo, password } = req.body || {};
  const identidad = usuario || correo;
  if (!identidad || !password) {
    return res.status(400).json({ error: "Completa usuario/correo y contraseña" });
  }
  try {
    const q = await pool.query(
      "SELECT id, nombre, correo, usuario, password_hash FROM usuarios WHERE usuario = $1 OR correo = $1",
      [identidad]
    );
    if (q.rowCount === 0) return res.status(401).json({ error: "Credenciales inválidas" });
    const u = q.rows[0];
    const ok = await bcrypt.compare(password, u.password_hash);
    if (!ok) return res.status(401).json({ error: "Credenciales inválidas" });

    
    return res.status(200).json({
      mensaje: "Login exitoso",
      usuario: { id: u.id, nombre: u.nombre, correo: u.correo, usuario: u.usuario }
    });
  } catch (e) {
    return res.status(500).json({ error: "Error en el login", detalle: e.message });
  }
});

export default router;
