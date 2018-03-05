 
CREATE Procedure [dbo].[Get_OrderByVersionId]
			@OrderVersionId int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 8/2/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_OrderCatalogVersion
*
*	Description:
*			
*
*	PARAMETERS: 
*			@OrderId	int 
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int;

			
			Select 
				oa.Organizationid,
				oa.OrderTypeId,
				o.Id OrderId, 
				o.[Order],
				o.IsReusable, 
				oa.OrderDescription,
				o.OrderCategoryId,
				oa.OrderNickname,
				o.AnswerInputTypeId,
				o.AnswerVersionGroupId,
				oa.OrderConfiguration,
				oa.Id OrderVersionId, 
				oa.OrderVersionAttribute
			From dbo.OrderCatalog o
			Inner Join dbo.OrderOrganization oa On
				o.Id = oa.OrderId
			Where oa.Id = @OrderVersionId
				
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
