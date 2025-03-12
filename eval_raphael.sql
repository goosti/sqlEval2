-- 1 Quels sont les services de l'hopital ?

SELECT * FROM service;

-- 3 Affichez le numéro de téléphone du patient ayant le prénom « antoine » :

SELECT telephone FROM patient WHERE prenom = "antoine";

-- 5 Affichez le nombre de patients (Alias : Nombre_de_patients) :

SELECT COUNT(*) AS "nombre_de_patient" FROM patient;

-- 7 Combien de chambres peuvent recevoir plusieurs patients simultanément ? (alias : nb) : 

SELECT COUNT(capacite) AS nb FROM chambre WHERE capacite > 1;

-- 9 Quel est le membre du personnel le plus jeune ?

SELECT * FROM personnel ORDER BY date_naissance DESC LIMIT 1;

-- 11 Quel est le salaire annuel de « Ophelie » ayant l’id « 13 » ? (alias : salaire_annuel)

SELECT (salaire * 12) AS "salaire_annuel" FROM personnel WHERE id_personnel = 13;

-- 13 Quel sont les prénoms des membres du personnel travaillant au service « urgence » ?

SELECT prenom, id_service FROM personnel WHERE id_service = 1;

-- 15 Dans quel(s) service(s) a séjourné la patiente ayant le prénom « elodie » ?

SELECT service.nom FROM service INNER JOIN chambre ON service.id_service = chambre.id_service INNER JOIN association_patient_chambre ON chambre.id_chambre = association_patient_chambre.id_chambre INNER JOIN patient ON association_patient_chambre.id_patient = patient.id_patient WHERE prenom = "elodie";

-- 17 Quels étaient les prénoms des patients se trouvant à l’hôpital entre le 01 février 2011 et le 15 février 2011, et dans quelle(s) chambre(s) se trouvaient-ils ?

SELECT patient.prenom,patient.id_patient,association_patient_chambre.id_chambre,association_patient_chambre.date_entree,patient.date_sortie
FROM patient
INNER JOIN association_patient_chambre ON patient.id_patient = association_patient_chambre.id_patient
WHERE association_patient_chambre.date_entree BETWEEN '2011-02-01' AND '2011-02-15' AND association_patient_chambre.date_sortie BETWEEN '2011-02-01' AND '2011-02-15';