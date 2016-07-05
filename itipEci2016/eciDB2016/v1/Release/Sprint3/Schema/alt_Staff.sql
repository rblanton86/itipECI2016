/***********************************************************************************************************
Description: Alters the Staff Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	6.22.16 - tpc - Added Column 'Handicapped'
************************************************************************************************************/

DECLARE @Staff int = 0
	
	SELECT @Staff = (
		SELECT object_id
		FROM sys.tables
		WHERE name = 'Staff' )

	SELECT @Staff	

IF ISNULL(@Staff, 0) = 0
	BEGIN

		CREATE TABLE Staff (
			staffID INT IDENTITY (1,1) PRIMARY KEY (staffID),
			staffTypeID INT FOREIGN KEY REFERENCES StaffType(staffTypeID),
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
			additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			sexID INT FOREIGN KEY REFERENCES Sex(sexID),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			staffAltID varchar(25),
			deleted bit,
			handicapped bit
			)

	END
ELSE
	BEGIN
		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @Staff AND name = 'handicapped')
			BEGIN
				PRINT 'Unneeded: Handicapped column exists'
			END
		ELSE 
			BEGIN
				ALTER TABLE Staff
					ADD handicapped bit
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @Staff = OBJECT_ID AND name = 'sexID')
			BEGIN
				PRINT 'Unneeded: sexID already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Staff
					ADD sexID INT FOREIGN KEY REFERENCES Sex(sexID)
				PRINT 'Added sexID column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @staff = OBJECT_ID AND name = 'staffAltID')
			BEGIN
				PRINT 'Unneeded: staffAltID already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Staff
					ADD staffAltID varchar(25) 
				PRINT 'Added staffAltID column on Staff Table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @staff = OBJECT_ID AND name = 'deleted')
			BEGIN
				PRINT 'Unneeded: deleted already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Staff
					ADD deleted bit 
				PRINT 'Added deleted column on Staff Table.'
			END
	END

		