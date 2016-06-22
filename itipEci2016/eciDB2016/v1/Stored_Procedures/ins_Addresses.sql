﻿/***********************************************************************************************************
Description: Stored Procedure that inserts address information into the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_Addresses]
	@address1 varchar(20),
	@address2 varchar(20),
	@city varchar(15),
	@st varchar(10),
	@zip int
AS
	BEGIN
		BEGIN TRY

			INSERT Addresses
			VALUES (@address1, @address2, @city, @st, @zip)

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

