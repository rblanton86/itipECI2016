/***********************************************************************************************************
Description: 
			Deletes the linking table for addresses and familymember
Author: 
	Tyrell Powers-Crane 
Date: 
	7.15.2016
Change History:
	
************************************************************************************************************/


DECLARE @var int = 0
	
	SELECT @var = (
		SELECT object_id
		FROM sys.tables
		WHERE name = 'LnkAddressesFamily' )


	IF ISNULL(@var, 0) = 0
		BEGIN
			SELECT * FROM sys.tables WHERE OBJECT_ID = @var AND name = 'LnkAddressesFamily'

					PRINT 'Unneeded: table doesnt exists'
		END	
	ELSE 
			BEGIN
				DROP TABLE LnkAddressesFamily
				PRINT 'DELETED LnkAddressesFamily'
			END

