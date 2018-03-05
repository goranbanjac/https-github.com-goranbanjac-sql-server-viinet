CREATE PROCEDURE [dbo].[GetChallenges]
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT
		SELECT	[Created_Date] AS createdDate,
				[Question] AS question,
				[SECU_Challenge_ID] AS ChallengeId
		FROM	[SECU_Challenge]
		ORDER BY [Question]
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0


