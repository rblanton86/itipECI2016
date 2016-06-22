﻿/***********************************************************************************************************
Description: Stored Procedure that retrieves the referral source from the ReferralSource Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_ReferralSource]
	@referralSourceID int

AS
	BEGIN
		BEGIN TRY

			SELECT referralSource
			FROM ReferralSource
			WHERE @referralSourceID = referralSourceID

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
