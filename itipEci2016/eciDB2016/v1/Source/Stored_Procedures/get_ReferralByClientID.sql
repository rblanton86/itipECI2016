/****************************************************************************
Description: Creates stored procedure get_ReferralByClientID.
        	
Author: Jennifer M. Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/
CREATE PROCEDURE [dbo].[get_ReferralByClientID]
	@clientID INT

AS
	BEGIN
		BEGIN TRY
			SELECT ref.*

			FROM Referral ref
				LEFT JOIN LnkClientReferral lnk
					ON lnk.referralID = ref.referralID
				LEFT JOIN Client clnt
					ON lnk.clientID = lnk.clientID

			WHERE clnt.clientID = @clientID
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