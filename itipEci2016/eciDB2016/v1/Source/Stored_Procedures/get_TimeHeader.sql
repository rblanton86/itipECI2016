﻿/***********************************************************************************************************
Description: Stored Procedure to pull information from the Time Header Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.05.2016
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_TimeHeader]
	@staffID int
	
AS
	BEGIN
		BEGIN TRY

			SELECT timeHeaderID, 
					staffID,
					ISNULL(weekEnding, ' ') AS weekEnding,
					deleted
					
			FROM TimeHeader 

			WHERE staffID = @staffID AND deleted <> 1


			

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

