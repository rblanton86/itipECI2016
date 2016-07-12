/***********************************************************************************************************
Description: Adds in dummy data for Clients 
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.12.16
Change History:

************************************************************************************************************/

	DECLARE @i int = 0

	WHILE @i <= 10 
	BEGIN

		SET @i += 1
			
			INSERT Staff (firstName, lastName, handicapped, 
							staffAltID, deleted, staffSSN, 
							addressesID, additionalContactInfoID)
			VALUES ('first' + CONVERT(VARCHAR(2), @i), 'Last' + CONVERT(VARCHAR(2), @i),
					0, 'staffAltID' + CONVERT(VARCHAR(2), @i), 0, 123456789, @i,
					1)

	END