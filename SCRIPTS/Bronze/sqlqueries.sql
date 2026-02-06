--------------------------------------------- CREATING DATABASE -----------------------------------
CREATE DATABASE Datawarehouse;
USE Datawarehouse;

--------------------------------------------- CREATING TABLES -----------------------------------
IF OBJECT_ID('bronze.crm_cust_info','U') is not null
DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date
);




IF OBJECT_ID('bronze.crm_prd_info','U') is not null
DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

IF OBJECT_ID('bronze.crm_sales_details','U') is not null
DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);


IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);


IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);


IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);


-------------------------------------------------- BULK INSERTING DATA INTO TABLES------------------------------------
CREATE PROCEDURE bronze.bronze_load AS
BEGIN
BEGIN TRY
PRINT'==========================================================';
PRINT'Loading Bronze Layer';
PRINT'==========================================================';


PRINT'----------------------------------------------------';
PRINT'Loading CRM Table';
PRINT'----------------------------------------------------';

PRINT'>> Truncating Table: bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;

PRINT'>> Inserting Data into: bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\user\OneDrive\Desktop\datasets\source_crm\cust_info.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR =',',
TABLOCK
);


PRINT'>> Truncating Table: bronze.crm_prd_info';
TRUNCATE TABLE bronze.crm_prd_info;

PRINT'>> Inserting Data into: bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\user\OneDrive\Desktop\datasets\source_crm\prd_info.CSV'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR =',',
TABLOCK
);


PRINT'>> Truncating Table: bronze.crm_Sales_details';
TRUNCATE TABLE bronze.crm_sales_details;

PRINT'>> Inserting Data into: bronze.crm_Sales_details';
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\user\OneDrive\Desktop\datasets\source_crm\sales_details.CSV'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

PRINT'----------------------------------------------------';
PRINT'Loading Erp Table';
PRINT'----------------------------------------------------';

PRINT'>> Truncating Table: bronze.erp_cust_az12';
TRUNCATE TABLE bronze.erp_cust_az12;

PRINT'>> Inserting Data into: bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\user\OneDrive\Desktop\datasets\source_erp\cust_az12.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR =',',
TABLOCK
);


PRINT'Truncating Table: bronze.erp_loc_a101';
TRUNCATE TABLE bronze.erp_loc_a101;

PRINT'Inserting Data Into: bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\user\OneDrive\Desktop\datasets\source_erp\loc_a101.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR=',',
TABLOCK
);

PRINT'Truncating Table: bronze.erp_px_cat_g1v2';
TRUNCATE TABLE bronze.erp_px_cat_g1v2;


PRINT'Inserting Data Into: bronze.erp_px_cat_g1v2';
BULK INSERT  bronze.erp_px_cat_g1v2
FROM 'C:\Users\user\OneDrive\Desktop\datasets\source_erp\px_cat_g1v2.CSV'
WITH
(
FIRSTROW=2,
FIELDTERMINATOR = ',',
TABLOCK
);
END TRY
BEGIN CATCH
PRINT'===============================================';
PRINT'Error occured during loading bronze layer';
PRINT'===============================================';
END CATCH

END 

