/***********************************************************************************************************
Description: Stored Procedure to updates first & last name of Staff Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[upd_Staff]
	@staffID int,
	@staffTypeID int,
	@addressesID int,
	@additionalContactInfoID int,
	@firstName varchar(20),
	@lastName varchar(20),
	@staffAltID int,
	@deleted bit,
	@handicapped bit
	
AS
	BEGIN
		BEGIN TRY
		
		UPDATE Staff 
		
		SET		staffTypeID = @staffTypeID,
				addressesID = @addressesID, 
				additionalContactInfoID = @additionalContactInfoID,
				firstName = @firstName,
				lastName = @lastName, 
				staffAltID = @staffAltID,
				deleted = @deleted,
				handicapped= @handicapped

		WHERE staffID = @staffID 
								

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
