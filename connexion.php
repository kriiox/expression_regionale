<?php

try
{
    $bdd = new PDO('mysql:host=localhost;dbname=bdd_expression;charset=utf8', 'root', '');
    $bdd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING); // On émet une alerte à chaque fois qu'une requête a échoué.
}
catch (Exception $e)
{
        die('Erreur : ' . $e->getMessage());
}
?>