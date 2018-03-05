CREATE PROCEDURE [dbo].[AddUserChallenge]
	@userId INT,
	@ChallengeId INT,
	@answer NVARCHAR(50),
	@displayOrder INT
AS
SET NOCOUNT ON
BEGIN TRY
	Declare 
		  @i						Int

	INSERT	[SECU_User_Challenge]
			(
				[Answer],
				[Display_Order],
				[SECU_Challenge_ID],
				[SECU_User_ID],
				[Created_Date]
			)
	VALUES
			(
				@answer,
				@displayOrder,
				@ChallengeId,
				@userId,
				GETUTCDATE()
			)
End Try
Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
End Catch
RETURN 0


