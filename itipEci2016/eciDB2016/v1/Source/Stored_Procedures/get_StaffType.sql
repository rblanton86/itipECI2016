﻿/***********************************************************************************************************
Description: Stored Procedure to pull type information from StaffType
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.14.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_StaffType]
	@staffTypeID int

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(staffType, ' ')

			FROM StaffType

			WHERE staffTypeID = @staffTypeID

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

