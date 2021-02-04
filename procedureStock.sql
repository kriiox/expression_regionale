/******************************************* CREATION DES PROCEDURES STOCKEES *******************************************/
Use BDD_Expression; -- utilise la BDD

DROP PROCEDURE IF EXISTS listeExpressionGroupeRegion; -- Supprime si elle existe déjà
CREATE PROCEDURE listeExpressionGroupeRegion (p_numGroupe INT, p_numRegion INT) 
    SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numRegion && num_Region = p_numRegion;


DROP PROCEDURE IF EXISTS ajoutExpression; -- Supprime si elle existe déjà
CREATE PROCEDURE ajoutExpression (p_mot varchar(255), p_numGroupe INT, p_numRegion INT) 
    INSERT INTO expression (mot, num_Groupe, num_Region) 
    VALUES (p_mot, p_numGroupe, p_numRegion);


DROP PROCEDURE IF EXISTS selectExpressionParId; -- Supprime si elle existe déjà
CREATE PROCEDURE selectExpressionParId (p_id INT) 
    SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE id_expression = p_id;


DROP PROCEDURE IF EXISTS selectGroupeExpression; -- Supprime si elle existe déjà
CREATE PROCEDURE selectGroupeExpression()
    SELECT id_expression, mots, num_Groupe, num_Region
    FROM expression 
    ORDER BY num_Groupe;


DROP PROCEDURE IF EXISTS selectExpressionParGroup; -- Supprime si elle existe déjà
CREATE PROCEDURE selectExpressionParGroup()
    SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numGroupe;


DROP PROCEDURE IF EXISTS updateExpressionParId; -- Supprime si elle existe déjà
CREATE PROCEDURE updateExpressionParId(p_id INT, p_mots varchar(255), p_numRegion INT, p_numGroupe INT) 
    UPDATE expression 
    SET mots = p_mots, num_Groupe = p_numGroupe, num_Region = p_numRegion 
    WHERE id_expression = p_id;

