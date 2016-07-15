/****************************************************************************
Description: Creates stored procedure get_PhysicianByClientID.
        	
Author: Jennifer M. Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/
CREATE PROCEDURE [dbo].[get_PhysicianByClientID]
	@clientID INT

AS
	BEGIN
		BEGIN TRY
			SELECT phys.*

			FROM Physician phys
				LEFT JOIN LnkClientPhysician lnk
					ON lnk.physicianID = phys.physicianID
				LEFT JOIN Clients clnt
					ON lnk.clientID = lnk.clientID

			WHERE clnt.clientID = 4026
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