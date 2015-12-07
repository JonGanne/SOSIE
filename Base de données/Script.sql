CREATE USER 'arlo_admin_db'@'localhost' IDENTIFIED BY 'admin';
CREATE DATABASE Arlo CHARACTER SET utf8 COLLATE utf8_general_ci ;
GRANT ALL ON arlo.* TO 'arlo_admin_db'@'localhost';
USE Arlo;

/* Creation de la table utilisateurs */
CREATE TABLE Utilisateurs
(
IdUtilisateur int NOT NULL AUTO_INCREMENT,
Login varchar(50) NOT NULL,
MdP varchar(50) NOT NULL,
LastName varchar(20) NOT NULL,
FirstName varchar(25) NOT NULL,
Email varchar(50),
Photo varchar(255),
PRIMARY KEY (IdUtilisateur)
);

/* Creation de la table salle */
CREATE TABLE Salle(
    IdSalle int NOT NULL AUTO_INCREMENT,
    Numero int,
    Capacite int,
    Pc bool,
    Videoprojecteur bool,
    TabNum bool,
    Handi bool,
    PRIMARY KEY(IdSalle)
    );
	
/* Creation de la table promotion */
CREATE TABLE Promotion(
    IdPromotion int NOT NULL AUTO_INCREMENT,
    Annee int,
    PRIMARY KEY(IdPromotion)
    );
CREATE TABLE ElevePromotion(
    IdPromotion int,
    IdUtilisateur int,
    PRIMARY KEY(IdPromotion, IdUtilisateur),
    FOREIGN KEY(IdPromotion) REFERENCES Promotion(IdPromotion),
    FOREIGN KEY(IdUtilisateur) REFERENCES Utilisateurs(IdUtilisateur)
    );

/* Creation de la table enseignants */
CREATE TABLE Enseignants(
IdEnseignant int NOT NULL AUTO_INCREMENT,
MaConf bool,
CharTd bool,
IdUtilisateur int,
PRIMARY KEY(IdEnseignant),
FOREIGN KEY(IdUtilisateur) REFERENCES Utilisateurs(IdUtilisateur)
);

CREATE TABLE Modules
(
    IdModule int NOT NULL AUTO_INCREMENT,
    Nom varchar(20),
    PRIMARY KEY(IdModule)
);

/* Creation de la table cours */
CREATE TABLE Cours(
    IdCours int NOT NULL AUTO_INCREMENT,
    IdSalle int,
    DateCours DATETIME,
    IdModule int,
    PRIMARY KEY(IdCours),
    FOREIGN KEY(IdSalle) REFERENCES Salle(IdSalle),
    FOREIGN KEY(IdModule) REFERENCES Modules(IdModule)
    );

/* Creation de la table Formation */
CREATE TABLE Formation
(
idFormation int NOT NULL AUTO_INCREMENT,
nomFormation varchar(50),
PRIMARY KEY(idMatiere)
);

/* Creation de la table Matiere */
CREATE TABLE Matiere
(
idMatiere int NOT NULL AUTO_INCREMENT,
nomMatiere varchar(255),
PRIMARY KEY(idMatiere )
);

/* Creation de la table Ue */
CREATE TABLE Ue
(
IdUe int NOT NULL AUTO_INCREMENT,
nomUe varchar(255),
idFormation int NOT NULL,
PRIMARY KEY(IdUe),
FOREIGN KEY(idFormation) REFERENCES Formation(idFormation)
);

/* Creation de la table MatiereUe */
CREATE TABLE MatiereUe
(
idMatiere int NOT NULL,
IdUe int NOT NULL,
PRIMARY KEY(idMatiere,IdUe),
FOREIGN KEY(idMatiere) REFERENCES Matiere(idMatiere),
FOREIGN KEY(IdUe ) REFERENCES Ue(IdUe )
);

/* Creation de la table Notes */
CREATE TABLE Notes
(
idNote int NOT NULL AUTO_INCREMENT,
IdEnseignant int NOT NULL,
idEleve int NOT NULL,
idMatiere int NOT NULL,
valeur int,
PRIMARY KEY(idNote),
FOREIGN KEY(idMatiere ) REFERENCES Matiere(idMatiere),
FOREIGN KEY(IdEnseignant) REFERENCES Enseignants(IdEnseignant),
FOREIGN KEY(idEleve) REFERENCES Utilisateurs(IdUtilisateur),
);

/* Creation de la table Absences */
CREATE TABLE Absences
(
idAbsence int NOT NULL AUTO_INCREMENT,
IdUtilisateur int NOT NULL,
dateAbsence Date,
matin bool,
apremMidi bool,
justification varchar(255),
justifie bool,
PRIMARY KEY(idAbsence),
FOREIGN KEY(IdUtilisateur) REFERENCES Utilisateurs(IdUtilisateur)
);


