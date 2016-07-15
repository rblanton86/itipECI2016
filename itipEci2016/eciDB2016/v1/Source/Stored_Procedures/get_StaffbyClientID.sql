/****************************************************************************
Description: Creates stored procedure get_StaffByClientID.
        	
Author: Jennifer M. Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/
CREATE PROCEDURE [dbo].[get_StaffByClientID]
	@clientID INT

AS
BEGIN
	BEGIN TRY
		SELECT stf.*

		FROM Staff stf
			LEFT JOIN LnkClientStaff lnk
				ON lnk.staffID = stf.staffID
			LEFT JOIN Clients clnt
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