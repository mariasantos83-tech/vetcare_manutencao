<?php
if (session_status() === PHP_SESSION_NONE) session_start();
$titulo = $titulo ?? 'VetCare';
?>
<!doctype html>
<html lang="pt-br">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= htmlspecialchars($titulo) ?> | VetCare</title>
<link rel="stylesheet" href="/vetcare_manutencao/assets/style.css">
</head>
<body>
<header class="topbar">
  <a class="brand" href="/vetcare_manutencao/index.php">🐾 VetCare</a>
  <nav>
    <?php if (!empty($_SESSION['usuario_id'])): ?>
      <a href="/vetcare_manutencao/index.php">Painel</a>
      <a href="/vetcare_manutencao/tutores/index.php">Tutores</a>
      <a href="/vetcare_manutencao/animais/index.php">Animais</a>
      <a href="/vetcare_manutencao/consultas/index.php">Consultas</a>
      <a href="/vetcare_manutencao/chamados/index.php">Suporte</a>
      <a href="/vetcare_manutencao/logout.php">Sair</a>
    <?php endif; ?>
  </nav>
</header>
<main class="container">
