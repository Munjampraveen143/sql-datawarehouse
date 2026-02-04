-- creating a database

create database datawarehouse;
use datawarehouse;

-- creating three schemas 1)bronze - load data and insert ,2) silver, 3)gold
create schema bronze;
create schema silver;
create schema gold;

-- queries to create tables
create table bronze.crm_cust_info (
cst_id int,
cst_key varchar(50),
cst_firstname varchar(50),
cst_lastname varchar(50),
cst_marital_status varchar(50),
cst_gendr varchar(50),
cst_create_date date
);

BULK INSERT bronze.crm_cust_info
from 'C:\Users\AMITHA\Downloads\datasets\datasets\source_crm\cust_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)


CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      VARCHAR(50),
    prd_nm       VARCHAR(50),
    prd_cost     INT,
    prd_line     VARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

BULK INSERT bronze.crm_prd_info
from 'C:\Users\AMITHA\Downloads\datasets\datasets\source_crm\prd_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)


CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  VARCHAR(50),
    sls_prd_key  VARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

BULK INSERT bronze.crm_sales_details
from 'C:\Users\AMITHA\Downloads\datasets\datasets\source_crm\sales_details.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)
  

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);

BULK INSERT bronze.erp_loc_a101
from 'C:\Users\AMITHA\Downloads\datasets\datasets\source_erp\loc_a101.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)


CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);

BULK INSERT bronze.erp_ust_az12
from 'C:\Users\AMITHA\Downloads\datasets\datasets\source_erp\CUST_AZ12.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)


CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           VARCHAR(50),
    cat          VARCHAR(50),
    subcat       VARCHAR(50),
    maintenance  VARCHAR(50)
);

BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\Users\AMITHA\Downloads\datasets\datasets\source_erp\px_cat_g1v2.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
)
  

