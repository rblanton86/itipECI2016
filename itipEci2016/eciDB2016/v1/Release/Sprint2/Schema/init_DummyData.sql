/***********************************************************************************************************
Description: Adds in dummy data for Clients 
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	06-22-2017 - jmg and tpc - Updated script to new file due to connection error and edited script to force results.
************************************************************************************************************/

	DECLARE @x int = 1
	DECLARE @i int = 0

	WHILE @i <= 10 AND @x <= 10
	BEGIN

		SET @i += 2
			
			INSERT Clients (firstName, lastName)
			VALUES ('First Name ' + CONVERT(VARCHAR(2), @i), 'Last Name ' + CONVERT(VARCHAR(2), @i))
			
			INSERT FamilyMember (firstName, lastName, isGuardian)
			SELECT 'Family FN ' + CONVERT(VARCHAR(2), @i), 'Family LN ' + CONVERT(VARCHAR(2), @i), 1
			UNION
			SELECT 'Family2 FN ' + CONVERT(VARCHAR(2), @i), 'Family2 LN ' + CONVERT(VARCHAR(2), @i), 1
				
			INSERT Addresses (address1)
			VALUES ('Akard # ' + CONVERT(VARCHAR(2), @i))	
			
			INSERT Staff (firstName, lastName)
			VALUES ('Staff FN ' + CONVERT(VARCHAR(2), @i), 'Staff LN ' + CONVERT(VARCHAR(2), @i))
			
			INSERT Physician (firstName, lastName)
			VALUES ('Phys FN ' + CONVERT(VARCHAR(2), @i), 'Phys LN ' + CONVERT(VARCHAR(2), @i))

			IF @i = 2 OR @i = 4 OR @i = 6
				BEGIN

					INSERT AdditionalContactInfo (additionalContactInfo)
					VALUES (CONVERT(VARCHAR(2), @i) + '23-456-7890')

					INSERT AdditionalContactInfoType (additionalContactInfoType)
					VALUES ('Phone ' + CONVERT(VARCHAR(2), @i))

				END

				

		SET @x += 2
			
			INSERT Clients (firstName, lastName)
			VALUES ('First Name ' + CONVERT(VARCHAR(2), @x), 'Last Name ' + CONVERT(VARCHAR(2), @x))

			INSERT FamilyMember (firstName, lastName, isGuardian)
			SELECT 'Family FN ' + CONVERT(VARCHAR(2), @x), 'Family LN ' + CONVERT(VARCHAR(2), @x), 1
			UNION
			SELECT 'Family2 FN ' + CONVERT(VARCHAR(2), @x), 'Family2 LN ' + CONVERT(VARCHAR(2), @x), 1
			UNION
			SELECT 'Family3 FN ' + CONVERT(VARCHAR(2), @x), 'Family3 LN ' + CONVERT(VARCHAR(2), @x), 1
			UNION
			SELECT 'Family4 FN ' + CONVERT(VARCHAR(2), @x), 'Family4 LN ' + CONVERT(VARCHAR(2), @x), 1

			INSERT Addresses (address1)
			VALUES ('ST. Paul # ' + CONVERT(VARCHAR(2), @x))

	END