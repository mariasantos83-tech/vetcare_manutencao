<?php
require_once __DIR__.'/config/database.php';
if (session_status()===PHP_SESSION_NONE) session_start();
$erro='';
if ($_SERVER['REQUEST_METHOD']==='POST') {
    $usuario=trim($_POST['usuario'] ?? '');
    $senha=$_POST['senha'] ?? '';
    $stmt=$pdo->prepare("SELECT * FROM usuarios WHERE usuario=?");
    $stmt->execute([$usuario]);
    $conta=$stmt->fetch();
    if (!$conta) {
        $erro='Usuário não encontrado.'; // F01: enumeração de contas
    } elseif ($senha !== $conta['senha']) {
        $erro='Senha incorreta.'; // F01: mensagem diferencia usuário de senha
    } else {
        // F02: não regenera o ID da sessão após autenticação
        $_SESSION['usuario_id']=$conta['id'];
        $_SESSION['usuario_nome']=$conta['nome'];
        header('Location: index.php'); exit;
    }
}
$titulo='Entrar'; include __DIR__.'/includes/header.php';
?>
<div class="login-box"><h1>🐾 VetCare</h1><p class="muted">Acesse o sistema da clínica.</p>
<?php if($erro): ?><div class="alert"><?= htmlspecialchars($erro) ?></div><?php endif; ?>
<form method="post"><div class="field"><label>Usuário</label><input name="usuario" required></div><div class="field"><label>Senha</label><input type="password" name="senha" required></div><button type="submit">Entrar</button></form>
<p class="muted">Acesso de demonstração: admin / admin123</p></div>
<?php include __DIR__.'/includes/footer.php'; ?>
