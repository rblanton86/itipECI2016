/***********************************************************************************************************
Description: Stored Procedure that updates family information of the Family Member Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	07-24-2016: Removed additional contact ID int, doesn't exist on family table.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[upd_FamilyMember]
	@familyMemberID int,
	@familyMemberTypeID int,
	@firstName varchar (25),
	@lastName varchar (25),
	@isGuardian bit


AS
	BEGIN
		BEGIN TRY

			UPDATE FamilyMember 
			
			SET		familyMemberTypeID = @familyMemberTypeID,
					firstName = @firstName,
					lastName = @lastName,
					isGuardian = @isGuardian
									
			WHERE familyMemberID = @familyMemberID

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



