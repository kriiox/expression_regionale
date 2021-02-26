<?php include 'header.php' ?>

    <div class="container">
    <div class="col-lg-12 text-center mt-5">
        <h1>Rechercher une expression régionale</h1>
    </div>
    <!-- Barre de recherche -->
    <div class="col-md-4 offset-md-4 mt-5 border border-success pt-3">
        <form action="index.php" method="GET" class="input-group mb-3">
            <input type="text" name="mot" class="form-control" placeholder="Search ......">
            <div class="input-group-append">
                <button type="submit" class="input-group-text"><i class="fa fa-search"></i></button>
            </div>
        </form>
    </div>

    <!-- Barre de refresh -->
    <div class="col-md-4 offset-md-4 pt-3">
        <form action="index.php" method="GET" class="input-group mb-3">
            <input readonly value="<?php if(isset($_GET['mot'])){ echo $_GET['mot'];} ?>" type="text" name="mot" class="form-control">
            <div class="input-group-append">
                <button type="submit" class="input-group-text"><i class="fas fa-sync-alt"></i></button>
            </div>
        </form>
    </div>
    
  
    <div class="col-md-4">
        <div id="mapLoad"></div>
    </div> 

<?php

    if (isset($_GET['mot'])) {
        $expression = $_GET["mot"];
        $num_groupe = 0;
        $arrayGlobal = array();
        $arrayExpressions = array();

        $listeExpression = SelectExpressionsByExpression($expression,$bdd);
        while($row = $listeExpression->fetch()){
            $arrayExpressions[] = $row['mots'];
        }
        $listeExpression->closeCursor();

        foreach($arrayExpressions as $expression){
            $listeId = SelectRegionsByExpression($expression,$bdd);
                if ($row = $listeId->fetch()) {
                    do {
                        $arrayTemp[] = $row['num_Region'];
                    } while ($row = $listeId->fetch());
                    $arrayGlobal[] = $arrayTemp;
                    unset($arrayTemp);
                }
            $listeId->closeCursor();
        }
        $JsonGlobal = json_encode ($arrayGlobal);

        $requete = SelectGroupeWithExpression($expression,$bdd);
        while($row = $requete->fetch()){
            $num_groupe = $row['num_Groupe'];
        }
        $requete->closeCursor();

        $requete2 = SelectExpressionsWithGroupe($num_groupe,$bdd);
        while($row = $requete2->fetch()){
            $listeExpressionAvecGroupe[] = $row['mots'];
        }
        $requete2->closeCursor();
        $JsonExpressions = json_encode ($listeExpressionAvecGroupe);
        echo "<span id='donnees'style='display : none'>".$JsonGlobal."</span>";
        echo "<span id='expressions'style='display : none'>".$JsonExpressions."</span>";

        ?>
        <script>
        setTimeout(function(){ importDonnees(); }, 1000);
        </script>
        <?php
    }
?>

<?php include 'footer.php' ?>

<script>
    $("#mapLoad").html(francefree());
</script>