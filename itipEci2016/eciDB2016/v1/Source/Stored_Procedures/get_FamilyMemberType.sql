﻿/***********************************************************************************************************
Description: Stored Procedure to pull type information from FamilyMemberType

Author: 
	Tyrell Powers-Crane 
Date: 
	7.14.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_FamilyMemberType]
	@familyMemberTypeID int

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(familyMemberType, ' ')
			FROM FamilyMemberType
			WHERE familyMemberTypeID = @familyMemberTypeID 

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

