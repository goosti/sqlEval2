/* 1 Quels sont les services de l’hôpital ? */

SELECT * FROM service;

/* 2  Affichez le prénom des patients : */

SELECT prenom FROM patient;

/* 3 Affichez le numéro de téléphone du patient ayant le prénom « antoine » : */

SELECT telephone FROM patient WHERE prenom = "antoine";

/* 4 Affichez le premier enregistrement de la table « personnel » :  */

SELECT * FROM personnel LIMIT 1;

/* 5 Affichez le nombre de patients (Alias : Nombre_de_patients) : */

SELECT COUNT(*) AS "nombre_de_patient" FROM patient;

/* 6  Affichez les membres du personnel ayant un salaire supérieur à « 1600 » €:*/

SELECT * FROM personnel WHERE salaire > 1600;

/* 7 Combien de chambres peuvent recevoir plusieurs patients simultanément ? (alias :
nb) : */

SELECT COUNT(capacite) AS nb FROM chambre WHERE capacite > 1;

/* 8  Affichez les prénoms des patients de sexe « féminin » dans l’ordre croissant des
prénoms */

SELECT prenom FROM patient WHERE sexe="f" ORDER BY prenom;

/* 9 Quel est le membre du personnel le plus jeune ?  */

SELECT * FROM personnel ORDER BY date_naissance DESC LIMIT 1;

/* 10  Quels sont les salaires moyens dans les différentes professions représentées au
sein de l’hôpital ? (en limitant à 2 chiffres après la virgule, en donnant l’alias
« salaire moyen » et en les classant dans l’ordre croissant). */

SELECT profession,ROUND(AVG(salaire),2) AS "salaire moyen" FROM personnel GROUP BY profession ORDER BY salaire;

/* 11 Quel est le salaire annuel de « Ophelie » ayant l’id « 13 » ? (alias : salaire_annuel)  */

SELECT (salaire * 12) AS "salaire_annuel" FROM personnel WHERE id_personnel = 13;

/* 12 Quelles étaient les chambres occupées entre le 01 février 2011 et le 15 février
2011 ?
 */
association_patient_chambre + patient
SELECT p.id_patient,apc.id_chambre,apc.date_entree,apc.date_sortie 
FROM patient p 
INNER JOIN association_patient_chambre apc 
ON p.id_patient = apc.id_patient 
WHERE apc.date_entree 
BETWEEN '2011-02-01' 
AND '2011-02-15' 
AND apc.date_sortie 
BETWEEN '2011-02-01' 
AND '2011-02-15';

/* 13 Quel sont les prénoms des membres du personnel travaillant au service « urgence »
?  */

SELECT prenom, id_service FROM personnel WHERE id_service = 1;

/* 14 Dans quelle(s) chambre(s) a séjourné la patiente ayant le prénom « elodie»? */

SELECT apc.id_chambre FROM association_patient_chambre apc INNER JOIN patient p ON apc.id_patient = p.id_patient WHERE p.prenom="elodie";

/* 15 Dans quel(s) service(s) a séjourné la patiente ayant le prénom « elodie » ?  */

SELECT service.nom FROM service INNER JOIN chambre ON service.id_service = chambre.id_service INNER JOIN association_patient_chambre ON chambre.id_chambre = association_patient_chambre.id_chambre INNER JOIN patient ON association_patient_chambre.id_patient = patient.id_patient WHERE prenom = "elodie";

/* 16 Affichez les informations sur les chambres du service « neurologie »  */

SELECT s.nom,c.id_chambre,c.capacite FROM service s INNER JOIN chambre c ON s.id_service = c.id_service WHERE s.nom = "neurologie";

/* 17 Quelsétaient les prénoms des patients se trouvantà l’hôpital entre le 01 février
2011 et le 15 février 2011, et dans quelle(s) chambre(s) se trouvaient-ils ?  */

SELECT patient.prenom,patient.id_patient,association_patient_chambre.id_chambre,association_patient_chambre.date_entree,patient.date_sortie
FROM patient
INNER JOIN association_patient_chambre ON patient.id_patient = association_patient_chambre.id_patient
WHERE association_patient_chambre.date_entree BETWEEN '2011-02-01' AND '2011-02-15' AND association_patient_chambre.date_sortie BETWEEN '2011-02-01' AND '2011-02-15';

/* 18 Un lit a été ajouté dans toutes les chambres du service « neurologie ». Modifiez
leur capacité. */

UPDATE chambre c JOIN service s ON c.id_service = s.id_service SET capacite = capacite+1 WHERE s.nom = "neurologie";

/* 19 Combien y’a-t-il d’infirmiers par service ? */

SELECT s.nom,COUNT(p.prenom) FROM service s INNER JOIN personnel p ON s.id_service = p.id_service WHERE p.profession = "infirmier" GROUP BY s.nom;

/* 20 Quel est le médecin potentiel qui s’est occupé de la patiente ayant le prénom
« charlotte » lors de son passage à l’hôpital ? */

SELECT p.prenom,p.nom,p.profession,p.id_service,apc.id_patient,apc.id_chambre 
FROM personnel p 
INNER JOIN chambre c
ON p.id_service = c.id_service
INNER JOIN association_patient_chambre apc
ON c.id_chambre = apc.id_chambre
INNER JOIN patient pa
ON apc.id_patient = pa.id_patient
WHERE pa.prenom = "charlotte"
AND p.profession = "medecin";