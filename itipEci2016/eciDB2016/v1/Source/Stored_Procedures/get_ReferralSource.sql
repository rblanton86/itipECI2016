﻿/***********************************************************************************************************
Description: Stored Procedure that retrieves the referral source from the ReferralSource Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
alter PROCEDURE [dbo].[get_ReferralSource]
	@referralSourceID int
	
AS
	BEGIN
		BEGIN TRY

			SELECT refs.*, 
					refs.referralSourceID,
					refs.additionalContactInfoID,
					referralSourceTypeID,
					refs.addressesID,
					ISNULL(referralSource, ' '),
					refs.deleted,
					ISNULL(aci.additionalContactInfo, ' '),
					ISNULL(addr.addressesID, 1)

			FROM ReferralSource refs
				LEFT JOIN AdditionalContactInfo aci ON
					refs.additionalContactInfoID = aci.additionalContactInfoID
				LEFT JOIN AdditionalContactInfoType acit ON
					refs.additionalContactInfoID = acit.additionalContactInfoTypeID
				LEFT JOIN Addresses addr ON
					refs.addressesID = addr.addressesID

			WHERE referralSourceID = @referralSourceID AND refs.deleted <> 1

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
