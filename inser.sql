CREATE TYPE ETAT AS ENUM('degrade','correct','parfait');

CREATE TYPE MATIERE AS ENUM('marbre','fer massif','bois','pierre','papier','bronze');
CREATE TYPE TECHNIQUE AS ENUM('aquarelle','huile','pastele');
CREATE TABLE musee(
    id_musee SERIAL PRIMARY KEY,
    nom_musee VARCHAR(20) NOT NULL,
    adresse VARCHAR(100) NOT NULL,
    service_ferme BOOLEAN NOT NULL 
);
CREATE TABLE theme(
    id_theme SERIAL PRIMARY KEY,
    nom_mouvement VARCHAR(20) NOT NULL,
    epoque VARCHAR(30) NOT NULL,
    description_mouvement VARCHAR(200) NOT NULL
);
CREATE TABLE visiteur(
    id_visiteur SERIAL PRIMARY KEY,
    login VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    nom VARCHAR(20) NOT NULL CHECK(nom LIKE '%[^A-Z]%'),
    mail VARCHAR(30) NOT NULL,
    tel INT NOT NULL,
    jeton_utilisateur BYTEA NOT NULL,
    id_musee SERIAL,
    CONSTRAINT fk_visiteur FOREIGN KEY (id_musee) REFERENCES musee(id_musee)
);

CREATE TABLE salle(
    id_salle SERIAL PRIMARY KEY,
    nom_salle VARCHAR(20) NOT NULL,
    nombre_visiteurs INT NOT NULL,
    max_visiteurs INT NOT NULL,
    id_musee SERIAL,
    id_theme SERIAL,
    CONSTRAINT fk_salle FOREIGN KEY (id_musee) REFERENCES musee(id_musee),
    CONSTRAINT fk_salle FOREIGN KEY (id_theme) REFERENCES musee(id_theme)
);

CREATE TABLE est_en_position(
    heure_position DATE NOT NULL,
    lattitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    id_visiteur SERIAL,
    id_salle SERIAL,
    CONSTRAINT fk_est_en_position FOREIGN KEY (id_visiteur) REFERENCES visiteur(id_visiteur),
    CONSTRAINT fk_est_en_position FOREIGN KEY (id_salle) REFERENCES salle(id_salle)
);



CREATE TABLE oeuvre(
    id_oeuvre SERIAL PRIMARY KEY,
    nom_oeuvre VARCHAR(50) NOT NULL,
    date_creation DATE NULL,
    txt_oeuvre VARCHAR(5000) NOT NULL,
    hauteur_oeuvre FLOAT CHECK(0<hauteur_oeuvre AND hauteur_oeuvre<10000) NOT NULL,
    largeur_oeuvre FLOAT CHECK(0<laugeur_oeuvre AND largeur_oeuvre<10000) NOT NULL,
    profondeur_oeuvre FLOAT CHECK(0<profondeur_oeuvre AND profondeur_oeuvre<10000) NOT NULL,
    audio_oeuvre BYTEA NULL,
    img_oeuvre BYTEA NULL,
    achettable BOOLEAN NULL,
    duree_creation TIME NULL,
    etat ETAT NOT NULL,
    CONSTRAINT fk_oeuvre FOREIGN KEY (artiste) REFERENCES artiste (id_artiste),
    CONSTRAINT fk_oeuvre FOREIGN KEY (id_musee) REFERENCES musee (id_musee)
);

CREATE TABLE commente(
   
    txt_commentaire CHAR(200) NOT NULL,
    note INT CHECK(0<note AND note<5) NOT NULL,
    heure_commentaire DATE NOT NULL,
    date_commentaire DATE NOT NULL,
    CONSTRAINT fk_commente FOREIGN KEY (id_visiteur) REFERENCES visiteur (id_visiteur),
    CONSTRAINT fk_commente FOREIGN KEY (id_oeuvre) REFERENCES oeuvre (id_oeuvre)
);

CREATE TABLE artiste(
    id_artiste SERIAL PRIMARY KEY,
    type_oeuvres VARCHAR(30) NOT NULL,
    txt_artiste VARCHAR(5000) NOT NULL,
    img_artiste BYTEA NULL,
    date_naissance DATE NULL,
    date_mort DATE NULL,
    CONSTRAINT fk_artiste FOREIGN KEY (mouvement) REFERENCES theme (id_theme)
);

CREATE TABLE sculpture(
    id_sculpture SERIAL PRIMARY KEY,
    matiere_sculpture MATIERE NOT NULL,
    nom_modele_sculpte VARCHAR(20) NOT NULL,
    CONSTRAINT fk_sculpture FOREIGN KEY (id_oeuvre) REFERENCES oeuvre (id_oeuvre)
);
CREATE TABLE peinture(
    id_peinture SERIAL PRIMARY KEY,
    technique_peinture TECHNIQUE NOT NULL,
    matiere_toile VARCHAR(20),
    nom_modele_peint VARCHAR(20) NULL,
    materiau_utilise VARCHAR(30) NOT NULL,
    CONSTRAINT fk_peinture FOREIGN KEY (id_oeuvre) REFERENCES oeuvre (id_oeuvre)
);