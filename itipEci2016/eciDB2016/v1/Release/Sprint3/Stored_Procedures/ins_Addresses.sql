﻿/***********************************************************************************************************
Description: Stored Procedure that inserts address information into the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[ins_Addresses]
	@addressTypeID int,
	@address1 varchar(20),
	@address2 varchar(20),
	@city varchar(15),
	@st varchar(10),
	@zip int,
	@deleted bit

AS
	BEGIN
		BEGIN TRY

			INSERT Addresses (addressesTypeID, 
								address1, 
								address2, 
								city, 
								st, 
								zip,
								deleted)

			VALUES (@addressTypeID, 
					@address1, 
					@address2, 
					@city, 
					@st, 
					@zip,
					@deleted)

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


