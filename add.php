<?php include 'header.php';

if(isset($_GET["groupe"]) && isset($_GET["expression"]) && isset($_GET["region"]) ){
        $expression = $_GET["expression"];
        $groupe = $_GET["groupe"];
        $region = $_GET["region"];
        ajoutExpression($expression,$groupe,$region,$bdd);
    }
?>
    <div class="container">
        <!--- Formulaire -->
        <h2>Affichage d'une expression </h2>
        <form name="affichageExpression" method="get" action="add.php">
            
            <label for="selectorRegion">Selectionner votre region :</label>
            <select name="selectorRegion" id="selectorRegion" onchange="afficherSelectGroupe()">
            <option disabled selected> ---- Selectionnez une region ---- </option>
                <?php
                    $regions = SelectRegions($bdd);
                    while ($donnees = $regions->fetch())
                    {
                ?>
                    <option value="<?php echo $donnees['id_Region']; ?>"> <?php echo $donnees['nom']; ?> </option>
                <?php
                    }
                    $regions->closeCursor(); // Termine le traitement de la requête
                ?>
            </select>
            </br>
            <label for="selectorGroupe" id="labelSelectorGroupe" style="display : none" >Entrez le groupe de l'expression :</label>
            <select name="selectorGroupe" id="selectorGroupe" style="display : none" onchange="afficherExpression()">
                <?php
                $groupes = SelectGroupe($bdd);
                while ($donnees = $groupes->fetch())
                    {
                ?>
                    <option value="<?php echo $donnees['id_Groupe']; ?>"> <?php echo $donnees['mots_Ref']; ?> </option>
                <?php
                    }
                $groupes->closeCursor(); // Termine le traitement de la requête
                ?>
            </select>
        </form>

        <span id="result"></span>         

    </div>

    <?php include 'footer.php' ?>