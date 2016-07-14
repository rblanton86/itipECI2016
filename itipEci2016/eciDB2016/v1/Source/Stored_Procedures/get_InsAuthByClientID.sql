/****************************************************************************
Description: Creates stored procedure get_InsAuthByClientID.
        	
Author: Jennifer M. Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/
CREATE PROCEDURE [dbo].[get_InsAuthByClientID]
	@clientID INT

AS
BEGIN
	BEGIN TRY
		SELECT ia.*,
			com.*

		FROM InsuranceAuthorization ia
			LEFT JOIN Comments com
				ON com.memberID = ia.insuranceAuthID
			LEFT JOIN Insurance ins
				ON ia.insuranceID = ins.insuranceID
			LEFT JOIN LnkClientInsurance lnk
				ON lnk.insuranceID = ins.insuranceID
			LEFT JOIN Clients clnt
				ON lnk.clientID = clnt.clientID
			WHERE clnt.clientID = @clientID
				AND com.memberTypeID = 7
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