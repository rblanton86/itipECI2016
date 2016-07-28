/***********************************************************************************************************
Description: Stored Procedure to pull type information from SchoolInfo table.
	 
Author: 
	Jennifer M Graves
Date: 
	7/27/2015
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AllSchoolInfo]

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(isd, ' ') AS isd,
				ISNULL(schoolInfoID, 1) AS schoolInfoID

			FROM SchoolInformation


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