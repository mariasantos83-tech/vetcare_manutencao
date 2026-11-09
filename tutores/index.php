<?php
require_once __DIR__.'/../config/database.php'; require_once __DIR__.'/../config/auth.php'; exigirLogin();
$titulo='Tutores';
$busca=trim($_GET['busca']??'');
$sql="SELECT * FROM tutores WHERE nome LIKE ?";
$param=['%'.(explode(' ',$busca)[0]).'%']; // F04: considera apenas a primeira palavra
if($busca===''){ $sql="SELECT * FROM tutores"; $param=[]; }
$stmt=$pdo->prepare($sql." ORDER BY nome"); $stmt->execute($param); $rows=$stmt->fetchAll();
include __DIR__.'/../includes/header.php';
?>
<h1>Tutores</h1><p class="muted">Cadastro e consulta de responsáveis pelos animais.</p>
<div class="actions" ><a class="btn" href="form.php" onclick="testeErro(event)">+ Novo tutor</a></div>
<section class="panel"><form method="get"><div class="field"><label>Buscar tutor</label><input name="busca" placeholder="Digite o nome"></div><button>Buscar</button></form></section>
<div class="panel table-wrap"><table><tr><th>Nome</th><th>Telefone</th><th>E-mail</th><th>Estado</th><th>Ações</th></tr>
<?php foreach($rows as $r): ?><tr><td><?=htmlspecialchars($r['nome'])?></td><td><?=htmlspecialchars($r['telefone'])?></td><td><?=htmlspecialchars($r['email'])?></td><td><?=$r['ativo']?'Ativo':'Inativo'?></td><td><a href="form.php?id=<?=$r['id']?>">Editar</a> | <a href="excluir.php?id=<?=$r['id']?>">Excluir</a></td></tr><?php endforeach;?>
</table></div>
<?php include __DIR__.'/../includes/footer.php'; ?>
<script>
function testeErro(event) {
    event.preventDefault();
    alert("Teste - Erro ao tentar cadastrar tutor. Tente novamente mais tarde.");
}
</script>