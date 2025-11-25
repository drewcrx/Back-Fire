import express from "express";
import { pool } from "../db/connection.js";

const router = express.Router();

/* ===========================
   GET TODOS LOS VEHÍCULOS
=========================== */
router.get("/", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM vehiculos ORDER BY placa ASC");
    res.json(Array.isArray(result.rows) ? result.rows : []);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener vehículos", detalle: error.message });
  }
});

/* ===========================
   GET VEHÍCULO POR PLACA
=========================== */
router.get("/:placa", async (req, res) => {
  const placa = String(req.params.placa || "").toUpperCase();

  try {
    const result = await pool.query(
      "SELECT * FROM vehiculos WHERE placa = $1",
      [placa]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Vehículo no encontrado" });
    }

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: "Error al obtener el vehículo", detalle: error.message });
  }
});

/* ===========================
   POST AGREGAR VEHÍCULO
=========================== */
router.post("/", async (req, res) => {
  const b = req.body || {};

  if (!b.marca || !b.modelo || !b.placa) {
    return res.status(400).json({ error: "Datos faltantes" });
  }

  const marca = String(b.marca);
  const modelo = String(b.modelo);
  const placa = String(b.placa).toUpperCase();
  const kilometraje = b.kilometraje ?? null;
  const ultima_visita = b.ultima_visita ?? null;

  try {
    await pool.query(
      `INSERT INTO vehiculos (marca, modelo, placa, kilometraje, ultima_visita)
       VALUES ($1, $2, $3, $4, $5)`,
      [marca, modelo, placa, kilometraje, ultima_visita]
    );

    res.json({ mensaje: "Vehículo agregado correctamente" });
  } catch (error) {
    console.error("DETALLE SQL:", error);
    res.status(500).json({ error: "Error al agregar el vehículo", detalle: error.message });
  }
});

/* ===========================
   DELETE VEHÍCULO POR PLACA
=========================== */
router.delete("/:placa", async (req, res) => {
  const placa = String(req.params.placa || "").toUpperCase();

  try {
    const result = await pool.query(
      "DELETE FROM vehiculos WHERE placa = $1",
      [placa]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Vehículo no encontrado" });
    }

    res.json({ mensaje: "Vehículo eliminado correctamente" });
  } catch (error) {
    console.error("Error al eliminar vehículo:", error);
    res.status(500).json({ error: "Error al eliminar vehículo" });
  }
});

/* ===========================
   GET ARREGLOS DE UN VEHÍCULO
=========================== */
router.get("/:placa/arreglos", async (req, res) => {
  const placa = String(req.params.placa || "").toUpperCase();

  try {
    const result = await pool.query(
      `SELECT * FROM arreglos 
       WHERE vehiculo_placa = $1
       ORDER BY fecha DESC`,
      [placa]
    );

    res.json(result.rows);
  } catch (error) {
    console.error("Error al obtener arreglos:", error);
    res.status(500).json({ error: "Error al obtener arreglos" });
  }
});

/* ===========================
   POST AGREGAR ARREGLO
=========================== */
router.post("/:placa/arreglos", async (req, res) => {
  const placa = String(req.params.placa || "").toUpperCase();
  const { descripcion, tipo } = req.body || {};

  if (!descripcion || !tipo) {
    return res.status(400).json({
      error: "La descripción y el tipo son obligatorios",
    });
  }

  try {
    await pool.query(
      `INSERT INTO arreglos (vehiculo_placa, descripcion, tipo)
       VALUES ($1, $2, $3)`,
      [placa, descripcion, tipo]
    );

    res.json({ mensaje: "Arreglo agregado correctamente" });
  } catch (error) {
    console.error("Error al agregar arreglo:", error);
    res.status(500).json({ error: "Error al agregar arreglo" });
  }
});

/* ===========================
   PUT CAMBIAR ESTADO ARREGLO
=========================== */
router.put("/arreglos/:id", async (req, res) => {
  const id = req.params.id;

  try {
    const result = await pool.query(
      `UPDATE arreglos 
       SET completado = NOT completado
       WHERE id = $1
       RETURNING *`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Arreglo no encontrado" });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error("Error al actualizar arreglo:", error);
    res.status(500).json({ error: "Error al actualizar arreglo" });
  }
});

/* ===========================
   PUT ACTUALIZAR VEHÍCULO (kilometraje / ultima_visita)
=========================== */
router.put("/:placa", async (req, res) => {
  const placa = String(req.params.placa || "").toUpperCase();
  const { kilometraje, ultima_visita } = req.body;

  try {
    const result = await pool.query(
      `UPDATE vehiculos
       SET kilometraje = $1,
           ultima_visita = $2
       WHERE placa = $3
       RETURNING *`,
      [kilometraje, ultima_visita, placa]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Vehículo no encontrado" });
    }

    res.json({
      mensaje: "Vehículo actualizado correctamente",
      vehiculo: result.rows[0]
    });
  } catch (error) {
    console.error("Error al actualizar vehículo:", error);
    res.status(500).json({ error: "Error al actualizar vehículo" });
  }
});


export default router;
