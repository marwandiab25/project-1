--alter table sheet1
--alter column saledate date


--populate peoperty address


select *
from sheet1
--where PropertyAddress is null
order by ParcelID


select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from sheet1 as a
join sheet1 as b
on a.parcelid=b.parcelid
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null
update a
set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from sheet1 as a
join sheet1 as b
on a.parcelid=b.parcelid
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

--breaking the PropertyAddress to address ,city
alter table sheet1
add Property_city nvarchar(255)

alter table sheet1
add Property_adress nvarchar(255)


select PropertyAddress
from sheet1
select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress )-1)as address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress )+1,len(PropertyAddress))as city

from sheet1

update sheet1
set Property_adress= SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress )-1)

update sheet1
set Property_city=SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress )+1,len(PropertyAddress))

select OwnerAddress
from sheet1

alter table sheet1
add owner_city nvarchar(255)
alter table sheet1
add owner_address nvarchar(255)

alter table sheet1
add owner_state nvarchar(255)

--working on the owner address

select PARSENAME(replace(owneraddress,',','.'),1)
from sheet1


update sheet1
set owner_state= PARSENAME(replace(owneraddress,',','.'),1)

update sheet1
set owner_city= PARSENAME(replace(owneraddress,',','.'),2)

update sheet1
set owner_address= PARSENAME(replace(owneraddress,',','.'),3)

select*
from sheet1



---change the yes and no in the sold as vacant


select SoldAsVacant,count(SoldAsVacant)
from sheet1
group by(SoldAsVacant)
order by 2

--select SoldAsVacant,
--case when SoldAsVacant='y' then 'yes'
--when SoldAsVacant ='N' then 'no'
--else SoldAsVacant
--end

--from sheet1

update sheet1
set SoldAsVacant=case when SoldAsVacant='y' then 'yes'
when SoldAsVacant ='N' then 'no'
else SoldAsVacant
end




-- removing duplicates


select ROW_NUMBER() over (partition by parcelid,propertyaddress,saleprice,saledate,legalreference
order by uniqueid) as rownumber
from sheet1

--put them in cte

with rownumbercte
as
(
select*, ROW_NUMBER() over (partition by parcelid,propertyaddress,saleprice,saledate,legalreference
order by uniqueid) as rownumber
from sheet1
)
select*
from rownumbercte
where rownumber>1

--delete un used columns 


alter table sheet1
drop column owneraddress,taxdistrict,propertyaddress


select*
from sheet1
