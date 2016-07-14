﻿/***********************************************************************************************************
Description: Stored Procedure to pull type information from ReferralSourceType

Author: 
	Tyrell Powers-Crane 
Date: 
	7.14.16
Change History:
	
************************************************************************************************************/
alter PROCEDURE [dbo].[get_referralSourceType]
	@referralSourceTypeID int

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(referralSourceType, ' '), ISNULL(referralNotificationType, ' ')
			FROM ReferralSourceType
			WHERE referralSourceTypeID = @referralSourceTypeID

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

