#Nivell 1
# Exercici 1
# A partir dels documents adjunts (estructura_dades i dades_introduir), importa les dues taules. 
#Mostra les característiques principals de l'esquema creat  i explica les diferents taules i variables 
#que existeixen. Assegura't d'incloure un diagrama que il·lustri la relació entre les diferents 
#taules i variables.

#En el caso de la tabla company, nos encontramos una tabla donde podemos encontrar informacion necesaria
#de cada empresa, como se llama, su numero de contacto, el mail su procedencia y un ID unico que nos servira
#más adelante para poder ver que movimientos ha tenido la empresa. En la tabla transaction, en cambio, parece
#más una tabla de hechos, donde encontramos cada transacción que han ido estableciendo las diferentes empresas.
#Nos podemos encontrar la misma empresa haciendo varias compras, a diferentes precios, en diferentes momentos,
#latitud, longitud. En este caso el registro único es la ID, y tenemos, por otra parte, los campos id del
#credit card, la id de la compañía y la ID del usuario que se podrían usar perfectamente como Foreign Keys
#para entablar con nuevas tablas a posteriori, soy consciente que no son FK hasta que no tenga un PK
#con el cual vincularlo. Adjunto el diagrama aparte.

#----------------------------------------------------------------------------------------------------------------------------

#- Exercici 2
# Realitza la següent consulta: Has d'obtenir el nom, email i país 
#de cada companyia, ordena les dades en funció del nom de les companyies.

SELECT company_name, email, country
FROM company
ORDER BY company_name;
#----------------------------------------------------------------------------------------------------------------------------

#Exercici 3
#Des de la secció de màrqueting et sol·liciten que els passis un llistat 
#dels països que estan fent compres.
SELECT DISTINCT(country)
FROM company
RIGHT JOIN transaction ON transaction.company_id = company.id
WHERE transaction.declined = 0;
#----------------------------------------------------------------------------------------------------------------------------

#- Exercici 4
#Des de màrqueting també volen saber des de quants països es realitzen 
#les compres.
SELECT COUNT(DISTINCT(country))
FROM company
RIGHT JOIN transaction ON transaction.company_id = company.id
WHERE transaction.declined = 0;
#----------------------------------------------------------------------------------------------------------------------------

#Exercici 5
#El teu cap identifica un error amb la companyia que té aneu 'b-2354'. 
#Per tant, et sol·licita que li indiquis el país i nom de companyia 
#d'aquest aneu.

SELECT DISTINCT(company.company_name), company.country
FROM company
JOIN transaction ON transaction.company_id = company.id
WHERE company_id = "b-2354";
#----------------------------------------------------------------------------------------------------------------------------

#Exercici 6
#A més, el teu cap et sol·licita que indiquis quina és la companyia 
#amb major despesa mitjana?

SELECT company.company_name, AVG(transaction.amount) AS media_gastos
FROM transaction
JOIN company ON company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY company_id
ORDER BY media_gastos DESC
LIMIT 1;
#----------------------------------------------------------------------------------------------------------------------------


#Nivell 2
#Exercici 1
#El teu cap està redactant un informe de tancament de l'any i et sol·licita 
#que li enviïs informació rellevant per al document. 
#Per a això et sol·licita verificar si en la base de dades existeixen 
#companyies amb identificadors (aneu) duplicats. 

SELECT company.id, COUNT(company.company_name)
FROM company
GROUP BY company.id
HAVING COUNT(company.company_name) > 1;
#----------------------------------------------------------------------------------------------------------------------------

#Exercici 2
#En quin dia es van realitzar les cinc vendes més costoses? 
#Mostra la data de la transacció i la sumatòria de la quantitat de diners.
SELECT DATE(timestamp) AS fecha, SUM(amount) AS cantidad_total
FROM transaction
WHERE transaction.declined = 0
GROUP BY fecha
ORDER BY cantidad_total DESC
LIMIT 5;
#----------------------------------------------------------------------------------------------------------------------------

#Exercici 3
#En quin dia es van realitzar les cinc vendes de menor valor? 
#Mostra la data de la transacció i la sumatòria de la quantitat de diners.

SELECT DATE(timestamp) AS fecha, SUM(amount) AS cantidad_total
FROM transaction
WHERE transaction.declined = 0
GROUP BY fecha
ORDER BY cantidad_total
LIMIT 5;
#----------------------------------------------------------------------------------------------------------------------------

#Exercici 4
#Quina és la mitjana de despesa per país? Presenta els resultats 
#ordenats de major a menor mitjà.

SELECT company.country, AVG(transaction.amount) as Media_dinero
FROM company
JOIN transaction ON transaction.company_id = company.id
WHERE transaction.declined = 0
GROUP BY company.country
ORDER BY Media_dinero DESC;
#----------------------------------------------------------------------------------------------------------------------------
#Nivell 3
#Exercici 1
#Presenta el nom, telèfon i país de les companyies, juntament amb la quantitat total gastada,
#d'aquelles que van realitzar transaccions amb una despesa compresa entre 100 i 200 euros. 
#Ordena els resultats de major a menor quantitat gastada.
SELECT company.company_name, company.phone, company.country, SUM(transaction.amount) as despesa
FROM company
JOIN transaction ON transaction.company_id = company.id
WHERE transaction.declined = 0
GROUP BY company.company_name, company.phone, company.country
HAVING despesa BETWEEN 100 AND 200
ORDER BY despesa DESC;

SELECT company.company_name, company.phone, company.country, SUM(transaction.amount) as despesa
FROM company
JOIN transaction ON transaction.company_id = company.id
WHERE transaction.declined = 0
GROUP BY company.company_name, company.phone, company.country
HAVING SUM(transaction.amount) BETWEEN 100 AND 200
ORDER BY SUM(transaction.amount) DESC;

#----------------------------------------------------------------------------------------------------------------------------
#Exercici 2
#Indica el nom de les companyies que van fer compres el 16 de març del 2022, 
#28 de febrer del 2022 i 13 de febrer del 2022. 

SELECT DISTINCT(company.company_name)
FROM company
JOIN transaction ON transaction.company_id = company.id
WHERE DATE(timestamp) IN ("2022-03-16","2022-02-28","2022-02-13") AND transaction.declined = 0
;







