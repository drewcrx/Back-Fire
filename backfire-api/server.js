import express from "express";
import cors from "cors";
import router from "./routes/vehiculos.js";
import usuariosRouter from "./routes/usuarios.js";
import { pool } from "./db/connection.js";

const app = express();
app.use(cors());
app.use(express.json());
app.use((req, res, next) => {
  req.body = req.body || {};
  next();
});
app.get("/health", (_req, res) => res.json({ ok: true }));

app.use("/vehiculos", router);
app.use("/usuarios", usuariosRouter);

const PORT = 3000;
app.listen(PORT, "0.0.0.0", () =>
  console.log(`Servidor corriendo en http://localhost:${PORT}`)
);
