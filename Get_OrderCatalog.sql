 
CREATE Procedure [dbo].[Get_OrderCatalog]
			@Id Int,
			@OrganizationId Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 6/28/2010
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_OrderCatalog
*
*	Description:
*			
*
*	PARAMETERS: 
*			@Id Int,
*			@OrganizationId Int
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Select 
			oca.Id OrderVersionId, 
			oca.OrganizationId, 
			oc.Id OrderId,
			oc.[Order],
			oc.OrderTypeId,
			oc.IsReusable,
			oca.OrderDescription,
			oc.OrderCategoryId,
			oca.OrderNickname,
			oc.AnswerInputTypeId,
			oc.AnswerVersionGroupId,
			oca.OrderConfiguration, 
			oca.OrderVersionAttribute
		From dbo.OrderCatalog oc
		Inner Join dbo.OrderOrganization oca On
			oc.Id = oca.OrderId
		Where oca.Id = @Id
		And oca.OrganizationId = @OrganizationId

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
