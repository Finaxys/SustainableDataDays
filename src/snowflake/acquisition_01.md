# WS : Acquisition & Stockage Snowflake

## Création d'une table de référentiels avec un import de fichier plat CSV

### Création de la table de référentiels

On crée d'abord une base de données avec un utilisateur qui a les droits adéquats puis la table `STRATEGIES`

```sql
-- Depuis un worksheet Snowsight
CREATE DATABASE SUSTAINABLE_DATA_DAYS;

USE DATABASE SUSTAINABLE_DATA_DAYS;
CREATE OR REPLACE TABLE STRATEGIES (
  STRATEGY STRING,
  ISIN STRING
);
```

### Insertion des données depuis un fichier CSV

On doit d'abord créer un type de fichier qui permet de décrire les traitements à effectuer à partir du fichier CSV

```sql
-- Depuis un worksheet Snowsight
CREATE OR REPLACE FILE FORMAT sustainable_dd_csv_format
    TYPE = 'CSV'
    FIELD_DELIMITER = ';';
```

À partir de cette table, on vient déposer le fichier CSV `strategies.csv` présent dans le dossier `resources` dans le stage propre à la table depuis Snowsight

```sql
-- Depuis un worksheet Snowsight
CREATE OR REPLACE STAGE sustainable_dd_stage
    FILE_FORMAT = sustainable_dd_csv_format
    COPY_OPTIONS = (ON_ERROR='skip_file')
    DIRECTORY = (ENABLE = TRUE);
```

Copie des données du fichier Excel dans la table

```sql
-- Depuis un worksheet Snowsight
COPY INTO "SUSTAINABLE_DATA_DAYS"."PUBLIC"."STRATEGIES"
FROM '@"SUSTAINABLE_DATA_DAYS"."PUBLIC"."SUSTAINABLE_DD_STAGE"/strategies.csv'
FILE_FORMAT = (FORMAT_NAME="SUSTAINABLE_DATA_DAYS"."PUBLIC"."SUSTAINABLE_DD_CSV_FORMAT")
ON_ERROR=ABORT_STATEMENT;
```
