CREATE PROCEDURE [dbo].[GetUserChallenges]
	@loginId NVARCHAR(50)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	[SECU_User_Challenge_ID] AS usrChallengeId,
				c.[SECU_Challenge_ID] AS ChallengeId,
				[Display_Order] AS displayOrder,
				[Question] AS question,
				[Answer] AS answer,
				c.[Created_Date] AS createdDate,
				uc.[SECU_User_ID] AS userId
		FROM	[SECU_User] u
				inner join [SECU_User_Challenge] uc on u.[SECU_User_ID] = uc.[SECU_User_ID]
				inner join [SECU_Challenge] c on uc.[SECU_Challenge_ID] = c.[SECU_Challenge_ID]
		WHERE	u.[User_Login_ID] = @loginId
		ORDER BY uc.[Display_Order]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


