<?php 


function AjoutExpression($mot,$num_groupe,$num_region){
    $bdd = new PDO('mysql:host=localhost;dbname=bdd_expression;charset=utf8', 'root', '');

    $reponseQuery = $bdd->query("call ajoutExpression('".$mot."',".$num_groupe.",".$num_region.")");
}

function ListeExpressionGroupeRegion($num_groupe,$num_region){
    $bdd = new PDO('mysql:host=localhost;dbname=bdd_expression;charset=utf8', 'root', '');

    $reponseQuery = $bdd->query("call listeExpressionGroupeRegion(".$num_groupe.",".$num_region.")");
    return $reponseQuery->fetch();
}

function SelectExpressionParGroup($num_groupe){
    $bdd = new PDO('mysql:host=localhost;dbname=bdd_expression;charset=utf8', 'root', '');

    $reponseQuery = $bdd->query("call selectExpressionParGroup(".$num_groupe.")");
    return $reponseQuery->fetch();
}

function SelectExpressionParId($id){
    $bdd = new PDO('mysql:host=localhost;dbname=bdd_expression;charset=utf8', 'root', '');

    $reponseQuery = $bdd->query("call selectExpressionParId(".$id.")");
    return $reponseQuery->fetch();
}

function SelectGroupeExpression($mot,$num_groupe,$num_region){
    $bdd = new PDO('mysql:host=localhost;dbname=bdd_expression;charset=utf8', 'root', '');

    $reponseQuery = $bdd->query("call selectGroupeExpression()");
    return $reponseQuery->fetch();
}

function UpdateExpressionParId($id,$mot,$num_groupe,$num_region){
    $bdd = new PDO('mysql:host=localhost;dbname=bdd_expression;charset=utf8', 'root', '');

    $reponseQuery = $bdd->query("call updateExpressionParId(".$id.",'".$mot."',".$num_groupe.",".$num_region.")");
}



$test = ListeExpressionGroupeRegion(1,1);

var_dump($test);

echo($test[1]);
?>