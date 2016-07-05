/***********************************************************************************************************
Description: Stored Procedure that updates address information into the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[upd_Addresses]
	@addressID int,
	@addressTypeID int,
	@address1 varchar(20),
	@address2 varchar(20),
	@city varchar(15),
	@st varchar(10),
	@zip int

AS
	BEGIN
		BEGIN TRY

			UPDATE Addresses 

			SET addressesTypeID = @addressTypeID,
				address1 = @address1,
				address2 = @address2,
				city = @city,
				st = @st,
				zip = @zip

			WHERE addressesID = @addressID

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


