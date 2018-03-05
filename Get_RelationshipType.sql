Create Procedure [dbo].[Get_RelationshipType]
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 8/04/2014
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_RelationshipType.sql
*
*	Description:
*			
*
*	PARAMETERS:
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

				Select  Id,Name From RelationshipType
				
	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		--If Xact_State() <> 0
		--	Rollback Transaction;
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0

--exec [dbo].[Get_RelationshipType] 2

