-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 08 fév. 2021 à 14:41
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bdd_expression`
--
CREATE DATABASE IF NOT EXISTS `bdd_expression` DEFAULT CHARACTER SET latin1 COLLATE latin1_bin;
USE `bdd_expression`;

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `ajoutExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutExpression` (`p_mot` VARCHAR(255), `p_numGroupe` INT, `p_numRegion` INT)  INSERT INTO expression (mot, num_Groupe, num_Region) 
    VALUES (p_mot, p_numGroupe, p_numRegion)$$

DROP PROCEDURE IF EXISTS `listeExpressionGroupeRegion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listeExpressionGroupeRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numRegion && num_Region = p_numRegion$$

DROP PROCEDURE IF EXISTS `selectExpressionParGroup`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroup` (`p_numGroupe` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numGroupe$$

DROP PROCEDURE IF EXISTS `selectExpressionParId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParId` (`p_id` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE id_expression = p_id$$

DROP PROCEDURE IF EXISTS `selectGroupeExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupeExpression` ()  SELECT id_expression, mots, num_Groupe, num_Region
    FROM expression 
    ORDER BY num_Groupe$$

DROP PROCEDURE IF EXISTS `updateExpressionParId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateExpressionParId` (IN `p_id` INT, IN `p_mots` VARCHAR(255), IN `p_numRegion` INT, IN `p_numGroupe` INT)  UPDATE expression 
SET mots = p_mots, num_Groupe = p_numGroupe, num_Region = p_numRegion 
WHERE id_expression = p_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `expression`
--

DROP TABLE IF EXISTS `expression`;
CREATE TABLE IF NOT EXISTS `expression` (
  `id_Expression` int(11) NOT NULL AUTO_INCREMENT,
  `mots` varchar(255) COLLATE latin1_bin NOT NULL,
  `num_Groupe` int(11) NOT NULL,
  `num_Region` int(11) NOT NULL,
  PRIMARY KEY (`id_Expression`),
  KEY `fk_numRegion_Region_idRegion` (`num_Region`),
  KEY `fk_numGroup_Groupe_idGroup` (`num_Groupe`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `expression`
--

INSERT INTO `expression` (`id_Expression`, `mots`, `num_Groupe`, `num_Region`) VALUES
(1, 'serpillère', 1, 1),
(2, 'toile', 1, 2),
(3, 'ouassingue', 1, 3),
(4, 'testremi', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

DROP TABLE IF EXISTS `groupe`;
CREATE TABLE IF NOT EXISTS `groupe` (
  `id_Groupe` int(11) NOT NULL AUTO_INCREMENT,
  `mots_Ref` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id_Groupe`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `groupe`
--

INSERT INTO `groupe` (`id_Groupe`, `mots_Ref`) VALUES
(1, 'serpillère');

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE IF NOT EXISTS `region` (
  `id_Region` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id_Region`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `region`
--

INSERT INTO `region` (`id_Region`, `nom`) VALUES
(1, 'centre'),
(2, 'normandie'),
(3, 'nord');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `expression`
--
ALTER TABLE `expression`
  ADD CONSTRAINT `expression_ibfk_1` FOREIGN KEY (`num_Groupe`) REFERENCES `groupe` (`id_Groupe`),
  ADD CONSTRAINT `fk_numRegion_Region_idRegion` FOREIGN KEY (`num_Region`) REFERENCES `region` (`id_Region`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
