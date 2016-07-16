/***********************************************************************************************************
Description: Stored Procedure to pull type information from MemberType
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.14.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_MemberType]
	@memberTypeID int

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(memberType, ' ')
			FROM MemberType
			WHERE memberTypeID = @memberTypeID

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


