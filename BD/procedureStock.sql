Use BDD_Expression;

DROP PROCEDURE IF EXISTS listeExpressionGroupeRegion; 
CREATE PROCEDURE listeExpressionGroupeRegion (p_numGroupe INT, p_numRegion INT) 
    SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numRegion && num_Region = p_numRegion;

DROP PROCEDURE IF EXISTS ajoutExpression; 
CREATE PROCEDURE ajoutExpression (p_mot varchar(255), p_numGroupe INT, p_numRegion INT) 
    INSERT INTO expression (mot, num_Groupe, num_Region) 
    VALUES (p_mot, p_numGroupe, p_numRegion);


DROP PROCEDURE IF EXISTS selectExpressionParId; 
CREATE PROCEDURE selectExpressionParId (p_id INT) 
    SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE id_Expression = p_id;



DROP PROCEDURE IF EXISTS updateExpressionParId; 
CREATE PROCEDURE updateExpressionParId(p_id INT, p_mots varchar(255), p_numRegion INT, p_numGroupe INT) 
    UPDATE expression 
    SET mots = p_mots, num_Groupe = p_numGroupe, num_Region = p_numRegion 
    WHERE id_Expression = p_id;



DROP PROCEDURE IF EXISTS selectGroupeExpression; 
CREATE PROCEDURE selectGroupeExpression()
    SELECT * 
    FROM expression 
    ORDER BY num_Groupe;


DROP PROCEDURE IF EXISTS selectExpressionParGroup; 
CREATE PROCEDURE selectExpressionParGroup(p_numGroupe INT)
    SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numGroupe;

DROP PROCEDURE IF EXISTS selectExpressionParGroupEtRegion; 
CREATE PROCEDURE selectExpressionParGroupEtRegion(p_numGroupe INT,p_numRegion INT)
    SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numGroupe && num_Region = p_numRegion;


DROP PROCEDURE IF EXISTS selectRegions; 
CREATE PROCEDURE selectRegions()
    SELECT *
    FROM region 
    ORDER BY nom;

    
DROP PROCEDURE IF EXISTS selectGroupe; 
CREATE PROCEDURE selectGroupe()
    SELECT *
    FROM groupe 
    ORDER BY mots_Ref;

DROP PROCEDURE IF EXISTS selectExpressionsByExpression; 
CREATE PROCEDURE selectExpressionsByExpression(p_mot varchar(255))
    SELECT DISTINCT mots FROM `expression` WHERE num_Groupe = ( SELECT num_Groupe FROM `expression` WHERE mots = p_mot LIMIT 1);

DROP PROCEDURE IF EXISTS selectRegionsByExpression; 
CREATE PROCEDURE selectRegionsByExpression(p_mot varchar(255))
    SELECT region_expression.num_Region
    FROM region_expression 
    INNER JOIN expression ON region_expression.num_Expression=expression.id_Expression
    WHERE expression.mots = p_mot;



DROP PROCEDURE IF EXISTS selectGroupeWithExpression; 
CREATE PROCEDURE selectGroupeWithExpression()
    SELECT num_Groupe from expression where mots = "toiles"

    
