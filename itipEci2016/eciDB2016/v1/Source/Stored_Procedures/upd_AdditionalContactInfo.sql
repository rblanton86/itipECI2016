﻿/***********************************************************************************************************
Description: Stored Procedure to update information into Additional Contact Info Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[upd_AdditionalContactInfo]
	@additionalContactInfoID int,
	@additionalContactInfo varchar (25),
	@memberTypeID int,
	@memberType varchar (25),
	@additionalContactInfoTypeID int,
	@additionalContactInfoType varchar (25)

	
AS
	BEGIN
		BEGIN TRY

			UPDATE AdditionalContactInfo 
			
			SET	memberType = @memberType,			
				additionalContactInfoType = @additionalContactInfoType,			
				additionalContactInfo = @additionalContactInfo

			WHERE additionalContactInfoID = @additionalContactInfoID
			

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


