/***********************************************************************************************************
Description: Stored Procedure that inserts address information into the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	07/25/2016: JMG & TPC - Updated stored procedure to return current value if exists.
	07/28/2016: JMG - Added input parameter for mapsco.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[ins_Addresses]
	@addressTypeID int,
	@address1 varchar(50),
	@address2 varchar(25),
	@city varchar(25),
	@st varchar(2),
	@zip int,
	@mapsco VARCHAR(25),
	@deleted bit,
	@addressID INT OUTPUT

AS
	BEGIN
		BEGIN TRY

			IF EXISTS (SELECT * FROM Addresses WHERE 
						addressesTypeID = @addressTypeID
						AND address1 = @address1
						AND address2 = ISNULL(@address2, '')
						AND city = @city 
						AND st = @st 
						AND zip = @zip
						AND mapsco = ISNULL(@mapsco, '')
						)

			BEGIN
				SET @addressID = (
						SELECT addressesID FROM Addresses
			
						WHERE	addressesTypeID = @addressTypeID
								AND address1 = @address1
								AND address2 = ISNULL(@address2, '')
								AND city = @city 
								AND st = @st 
								AND zip = @zip
								AND mapsco = ISNULL(@mapsco, '')
								)

				RETURN @addressID 
			END
		ELSE
			BEGIN
				INSERT Addresses (addressesTypeID, 
									address1, 
									address2, 
									city, 
									st, 
									zip,
									mapsco,
									deleted)

				VALUES (@addressTypeID, 
						@address1, 
						ISNULL(@address2, ''),
						@city, 
						@st, 
						@zip,
						ISNULL(@mapsco, ''),
						@deleted)

				SET @addressID = (
						SELECT addressesID FROM Addresses
			
						WHERE	addressesTypeID = @addressTypeID
								AND address1 = @address1
								AND address2 = ISNULL(@address2, '')
								AND city = @city 
								AND st = @st 
								AND zip = @zip
								AND mapsco = ISNULL(@mapsco, '')
								)

				RETURN @addressID 
			END

		END TRY
		BEGIN CATCH

			DECLARE @timeStamp DATETIME,
				@errorMessage VARCHAR(255),
				@errorProcedure VARCHAR(100)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			RETURN 0
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

		END CATCH
	END


