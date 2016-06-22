/***********************************************************************************************************
Description: Adds in dummy data for Clients 
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/

	DECLARE @x int = 1
	DECLARE @i int = 0

	WHILE @i <= 10 AND @x <= 10
	BEGIN

		SET @i += 2
			
			INSERT Clients 
			VALUES ('First Name ' + CONVERT(VARCHAR(2), @i), 'Last Name ' + CONVERT(VARCHAR(2), @i))
			
			INSERT FamilyMember
			SELECT 'Family FN ' + CONVERT(VARCHAR(2), @i), 'Family LN ' + CONVERT(VARCHAR(2), @i), true
			UNION
			SELECT 'Family2 FN ' + CONVERT(VARCHAR(2), @i), 'Family2 LN ' + CONVERT(VARCHAR(2), @i), true
				
			INSERT Addresses
			VALUES ('Akard # ' + CONVERT(VARCHAR(2), @i))			

			IF @i = 3 OR @i = 5 OR @i = 7
				BEGIN

					INSERT AdditionalContactInfo
					VALUES (CONVERT(VARCHAR(2), @i) + '123-456-7890')

					INSERT AdditionalContactInfoType
					VALUES ('Phone ' + CONVERT(VARCHAR(2), @i))

				END



		SET @x += 2
			
			INSERT Clients
			VALUES ('First Name ' + CONVERT(VARCHAR(2), @x), 'Last Name ' + CONVERT(VARCHAR(2), @x))

			INSERT FamilyMember
			SELECT 'Family FN ' + CONVERT(VARCHAR(2), @x), 'Family LN ' + CONVERT(VARCHAR(2), @x), true
			UNION
			SELECT 'Family2 FN ' + CONVERT(VARCHAR(2), @x), 'Family2 LN ' + CONVERT(VARCHAR(2), @x), true
			UNION
			SELECT 'Family3 FN ' + CONVERT(VARCHAR(2), @x), 'Family3 LN ' + CONVERT(VARCHAR(2), @x), true
			UNION
			SELECT 'Family4 FN ' + CONVERT(VARCHAR(2), @x), 'Family4 LN ' + CONVERT(VARCHAR(2), @x), true

			INSERT Addresses
			VALUES ('ST. Paul # ' + CONVERT(VARCHAR(2), @x))

	END

	
