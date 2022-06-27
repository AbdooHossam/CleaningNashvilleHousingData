
--Cleaning data in SQL queries

 select*
 from DataCleaning..Sheet1


  --standarize Date format

 select SaleDateConverted, convert(date,SaleDate)
 from DataCleaning..Sheet1

 Update Sheet1
 Set SaleDate = convert(date,SaleDate)

 Alter Table Sheet1
 Add SaleDateConverted Date;

 Update Sheet1
 Set SaleDateConverted = convert(date,SaleDate)



 --Populate Property Adress Data

 select *
 from DataCleaning..Sheet1
 --where PropertyAddress is null
 order by ParcelID

 select a.ParcelID, a.PropertyAddress, b.ParcelID,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
 from DataCleaning..Sheet1 a
 Join DataCleaning..Sheet1 b
    on a.ParcelID = b.ParcelID
	and a.UniqueID<> b.UniqueID
 where a.PropertyAddress is Null

 update a
 set PropertyAddress= isnull(a.PropertyAddress,b.PropertyAddress)
 from DataCleaning..Sheet1 a
 Join DataCleaning..Sheet1 b
    on a.ParcelID = b.ParcelID
	and a.UniqueID<> b.UniqueID
	where a.PropertyAddress is Null


--Breaking out Adress into indvidual colums (Adress, city, state)

select PropertyAddress
 from DataCleaning..Sheet1
 --where PropertyAddress is null
 --order by ParcelID

 select
 SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1) as Adress
 ,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress)) as City
 
 from DataCleaning..Sheet1

 Alter Table Sheet1
 Add PropertysplitAddress Nvarchar(255);

 Update Sheet1
 Set PropertysplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1)

 Alter Table Sheet1
 Add PropertysplitCity Nvarchar(255);

 Update Sheet1
 Set PropertysplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress))

 select*
  from DataCleaning..Sheet1


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From DataCleaning..Sheet1

 Alter Table Sheet1
 Add OwnersplitAddress Nvarchar(255);

 Update Sheet1
 Set OwnersplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1)

 Alter Table Sheet1
 Add OwnersplitCity Nvarchar(255);

 Update Sheet1
 Set OwnersplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress))


  Alter Table Sheet1
 Add OwnersplitState Nvarchar(255);

 Update Sheet1
 Set OwnersplitState = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress))