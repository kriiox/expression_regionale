<?php 
include "connexion.php";
include "API.php";

if($_GET["region"] && $_GET["groupe"]){
    $region=$_GET["region"];
    $groupe = $_GET["groupe"];
    $result = SelectExpressionParGroupRegion($groupe,$region,$bdd);
    $num_of_rows = $result->rowCount();
    if($num_of_rows != 0){
        $row = $result->fetch();
        echo"Voici l'expression associée : ".$row['mots'];
    }else{
        echo("<form name='ajoutExpression' method='get' action='add.php'>
        <p style='color : red'>Aucune expression enregistrée</p>
        <h2>Ajout de l'expression</h2>
        <label for='expression'>Saisir l'expression :</label>
        <input type='text' name='groupe' style='display : none' id='groupe' value='".$groupe."'>
        <input type='text' name='region' style='display : none' id='region' value='".$region."'>

        <input type='text' name='expression' id='expression'>
            <input type='submit' name='valider' value='Ajouter'/>
        </form>");
    }
    
    $result->closeCursor();
}
  ?>