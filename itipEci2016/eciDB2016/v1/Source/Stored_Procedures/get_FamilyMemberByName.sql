/***********************************************************************************************************
Description: Stored Procedure that retrieves family information from the Family Member Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_FamilyMemberByName]
	@firstName varchar (25),
	@lastName varchar (25)


AS
	BEGIN
		BEGIN TRY

			SELECT fmb.*, fmbt.familyMemberType, aci.additionalContactInfoID

				FROM FamilyMember fmb
					LEFT JOIN FamilyMemberType fmbt ON
						fmb.familyMemberTypeID = fmbt.familyMemberTypeID
					LEFT JOIN AdditionalContactInfo aci ON
						fmb.additionalContactInfoID = aci.additionalContactInfoID

			WHERE (firstName = @firstName) AND (lastName = @lastName)

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



