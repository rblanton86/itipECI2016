/***********************************************************************************************************
Description: Stored Procedure that updates the referral source of the Referral Source Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[upd_ReferralSource]
	@referralSourceID int,
	@additionalContactInfoID int,
	@referralSourceTypeID int,
	@addressesID int,
	@referralSource varchar(20)

AS
	BEGIN
		BEGIN TRY
			
			UPDATE ReferralSource 
			
			SET		additionalContactInfoID =  @additionalContactInfoID,
					referralSourceTypeID = @referralSourceTypeID, 
					addressesID = @addressesID, 
					referralSource = @referralSource

			WHERE referralSourceID = @referralSourceID 
					
					
					

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
