/***********************************************************************************************************
Description: Stored Procedure that updates address information into the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	07/24/2016: JMG - Corrected spelling error.
	08/09/2016: JMG - Updated to add county column and needed memberID and memberTypeID.
************************************************************************************************************/
CREATE PROCEDURE [dbo].[upd_Addresses]
	@addressesID INT,
	@memberID INT,
	@memberTypeID INT,
	@addressesTypeID int,
	@address1 varchar(50),
	@address2 varchar(25),
	@city varchar(25),
	@st varchar(2),
	@zip int,
	@mapsco VARCHAR(25),
	@county VARCHAR(25)

AS
	BEGIN
		BEGIN TRY

			IF EXISTS (SELECT *
						FROM LnkAddressMember
						WHERE memberID = @memberID
							AND memberTypeID = @memberTypeID)
				BEGIN
					UPDATE Addresses

					SET addressesTypeID = @addressesTypeID,
						address1 = @address1,
						address2 = @address2,
						city = @city,
						st = @st,
						zip = @zip

					WHERE addressesID = @addressesID
				END
			ELSE
				BEGIN
					UPDATE Addresses

					SET addressesTypeID = @addressesTypeID,
						address1 = @address1,
						address2 = @address2,
						city = @city,
						st = @st,
						zip = @zip

					WHERE addressesID = @addressesID

					INSERT INTO LnkAddressTable (memberID, memberTypeID, addressesID)
						VALUES (@memberID, @memberTypeID, @addressesID)
				END

		END TRY
		BEGIN CATCH

			DECLARE @timeStamp DATETIME,
				@errorMessage VARCHAR(255),
				@errorProcedure VARCHAR(100)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

		END CATCH
	END