/***********************************************************************************************************
Description: Stored Procedure that inserts referral source into the Referral Source Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_ReferralSource]
	@additionalContactInfoID int,
	@referralSourceTypeID int,
	@addressesID int,
	@referralSource varchar(20)

AS
	BEGIN
		BEGIN TRY
			
			INSERT ReferralSource (additionalContactInfoID,
									referralSourceTypeID, 
									addressesID, 
									referralSource)

			VALUES (@additionalContactInfoID, 
					@referralSourceTypeID, 
					@addressesID, 
					@referralSource)

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
