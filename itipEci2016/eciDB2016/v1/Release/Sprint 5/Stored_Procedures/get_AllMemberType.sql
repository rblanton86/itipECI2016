/***********************************************************************************************************
Description: Stored Procedure to pull type information from MemberType
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.121.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AllMemberType]

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(memberType, ' ') AS memberType,
					ISNULL(memberTypeID, 0) AS memberTypeID
			FROM MemberType

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


