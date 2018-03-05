CREATE PROCEDURE [dbo].[RegisterACName]
	@category NVARCHAR(50),
	@ACname NVARCHAR(50),
	@descr NVARCHAR(500) = NULL
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT

		If Exists ( Select 1 From dbo.SECU_Access_Control_Entity where category = @category And Name = @ACname )
			Throw 50001, N'Object with such name for given category alredy exist', 1;
			Insert 
				dbo.SECU_Access_Control_Entity 
					( Category, Name, Description)
			Values  
				( @category, @ACname, @descr )
END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
