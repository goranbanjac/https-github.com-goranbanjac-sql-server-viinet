
 
Create Procedure [dbo].[Get_OrderCatalogId]
			@OrderVersionId	Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 7/29/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_OrderCatalogId
*
*	Description:
*			
*
*	PARAMETERS: 
*			@OrderVersionId	Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Select OrderId OrderCatalogId From dbo.OrderOrganization where Id = @OrderVersionId

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
