<?php 
function AjoutExpression($mot,$num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call ajoutExpression('".$mot."',".$num_groupe.",".$num_region.")");
}

function ListeExpressionGroupeRegion($num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call listeExpressionGroupeRegion(".$num_groupe.",".$num_region.")");
    return $reponseQuery;
}

function SelectExpressionParGroupRegion($num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call selectExpressionParGroupEtRegion(".$num_groupe.",".$num_region.")");
    return $reponseQuery;
}

function SelectExpressionParGroup($num_groupe,$bdd){
    $reponseQuery = $bdd->query("call selectExpressionParGroup(".$num_groupe.")");
    return $reponseQuery;
}

function SelectExpressionParId($id,$bdd){
    $reponseQuery = $bdd->query("call selectExpressionParId(".$id.")");
    return $reponseQuery;
}

function SelectGroupeExpression($mot,$num_groupe,$num_region,$bdd){
    $reponseQuery = $bdd->query("call selectGroupeExpression()");
    return $reponseQuery;
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

function maxExpression($bdd){
    $maxExpression = $bdd->query("SELECT MAX(id_Expression) FROM expression");
    return $maxExpression;
}
?>