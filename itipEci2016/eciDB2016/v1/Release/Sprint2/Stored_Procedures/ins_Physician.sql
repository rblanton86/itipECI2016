﻿/***********************************************************************************************************
Description: Stored Procedure to insert physician information into the physician table 
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_Physician]
	@addressesID int,
	@additionalContactInfoID int,
	@title varchar(10),
	@firstName varchar (25),
	@lastName varchar (25)

AS
	BEGIN
		BEGIN TRY

			INSERT Physician (addressesID,
								additionalContactInfoID,
								title,
								firstName,
								lastName)

			VALUES (@addressesID,
					@additionalContactInfoID,
					@title,
					@firstName,
					@lastName)
				
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
