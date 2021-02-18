<?php 
function AjoutExpression($mot,$num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call ajoutExpression('".$mot."',".$num_groupe.",".$num_region.")");
}

function ListeExpressionGroupeRegion($num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call listeExpressionGroupeRegion(".$num_groupe.",".$num_region.")");
    return $reponseQuery->fetch();
}

function SelectExpressionParGroupRegion($num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call selectExpressionParGroupEtRegion(".$num_groupe.",".$num_region.")");
    return $reponseQuery->fetch();
}

function SelectExpressionParGroup($num_groupe,$bdd){
    $reponseQuery = $bdd->query("call selectExpressionParGroup(".$num_groupe.")");
    return $reponseQuery->fetch();
}

function SelectExpressionParId($id,$bdd){
    $reponseQuery = $bdd->query("call selectExpressionParId(".$id.")");
    return $reponseQuery->fetch();
}

function SelectGroupeExpression($mot,$num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call selectGroupeExpression()");
    return $reponseQuery->fetch();
}

function SelectRegions($bdd){
    $reponseQuery = $bdd->query("call selectRegions()");
    return $reponseQuery;
}

function SelectGroupe($bdd){
    $reponseQuery = $bdd->query("call selectGroupe()");
    return $reponseQuery;
}

function UpdateExpressionParId($id,$mot,$num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call updateExpressionParId(".$id.",'".$mot."',".$num_groupe.",".$num_region.")");
}
?>