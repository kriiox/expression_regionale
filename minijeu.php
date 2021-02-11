<?php include 'header.php'

?>

    <div class="container">
        <div class="text-center">
            <p class="display-3">Le mini-jeu des expressions</p>
        </div>
        <div class="row mt-5 justify-content-md-center">    
            <!-- Mot aléatoire -->
            <div class="col-md-4  border border-success pt-4 display-4">
                <p id="mot_alea" class="text-center">Aléatoire</p>   
            </div>

            <!-- Bouton de refresh -->
            <div class="col-md-auto p-2 m-4">
                <a style="background-color: #990099; border-color: #990099;" class="btn btn-primary btn-lg" href="minijeu.php"><i class="fas fa-sync-alt"></i></a>
            </div>
        </div>
        <!-- Le form avec les checkbox et les deux boutons -->
        <div class="row mt-5 justify-content-md-center">
            <form class="form display-5">
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="exampleCheck1">
                    <label class="form-check-label" for="exampleCheck1">Centre</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="exampleCheck2">
                    <label class="form-check-label" for="exampleCheck2">Rhônes Alpes</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="exampleCheck3">
                    <label class="form-check-label" for="exampleCheck3">Bretagne</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="exampleCheck4">
                    <label class="form-check-label" for="exampleCheck4">Normandie</label>
                </div>
                <button style="background-color: #990099; border-color: #990099;" type="button" class="btn btn-primary mt-5 btn-lg">Valider</button>
                <button style="display: none; background-color: #990099; border-color: #990099;" type="button" class="btn btn-primary mt-5 btn-lg">Rejouer</button>
            </form>
        </div>
    </div>

<?php include 'footer.php' ?>