CREATE Procedure [dbo].[Add_Privilege]
     @Id		Int 
	,@Privilege	NVarchar (50)
AS
SET NOCOUNT ON
BEGIN TRY
	DECLARE @i INT

	If Exists ( Select 1 From dbo.SECU_Privilege Where Privilege = @Privilege)
	Or Exists ( Select 1 From dbo.SECU_Privilege Where Id = @Id )
					Throw 50001, N'This Privilege already exist', 1

					 Insert dbo.SECU_Privilege ( Id, Privilege )
					 Values (@Id, @Privilege)

END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0

