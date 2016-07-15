/****************************************************************************
Description: Creates stored procedure get_CommentsByClientID.
        	
Author: Jennifer M. Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/
CREATE PROCEDURE [dbo].[get_CommentsByClientID]
	@clientID INT

AS
BEGIN
	BEGIN TRY
		SELECT com.commentsID,
				ISNULL(com.comments, ' ') AS comments,
				com.deleted

		FROM Comments com
			LEFT JOIN Clients clnt
				ON clnt.clientID = com.memberID AND com.deleted <> 1

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