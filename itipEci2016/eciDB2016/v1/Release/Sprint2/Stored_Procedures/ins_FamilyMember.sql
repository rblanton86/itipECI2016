/***********************************************************************************************************
Description: Stored Procedure that inserts family information into the Family Member Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_FamilyMember]
	@familyMemberTypeID int,
	@additionalContactInfoID int,
	@firstName varchar (25),
	@lastName varchar (25),
	@isGuardian bit


AS
	BEGIN
		BEGIN TRY

			INSERT FamilyMember (familyMemberTypeID,
									additionalContactInfoID,
									firstName,
									lastName,
									isGuardian)
									
			VALUES (@familyMemberTypeID,
					@additionalContactInfoID,
					@firstName,
					@lastName,
					@isGuardian)	

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



