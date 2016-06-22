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

IF @Staff = 0
	BEGIN

		CREATE TABLE Staff (
			staffID INT IDENTITY (1,1) PRIMARY KEY (staffID),
			staffTypeID INT FOREIGN KEY REFERENCES StaffType(staffTypeID),
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
			additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			handicapped bit
			)

	END
ELSE
	BEGIN
		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @Staff AND name = 'handicapped')
			BEGIN
				RETURN
			END
	ELSE 
	BEGIN

		ALTER TABLE Staff
			ADD handicapped bit

	END
END
