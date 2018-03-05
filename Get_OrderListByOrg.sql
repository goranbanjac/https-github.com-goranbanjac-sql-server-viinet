
CREATE Procedure [dbo].[Get_OrderListByOrg]
		 @OrganizationId	Int,
		 @OrderTypeId		Int
		
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Get_OrderById
*
*	Description:
*			
*
*	PARAMETERS: 
*
* Exec [dbo].[Get_OrderById]
*		 @Id					Int	= null
*		,@OrganizationId		Int
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i	Int

			Select 
				oa.Organizationid,
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
				oa.OrderVersionAttribute,
				@OrderTypeId OrderTypeId
			From dbo.OrderCatalog o
			Inner Join dbo.OrderOrganization oa On
				o.Id = oa.OrderId
			Where oa.OrganizationId = @OrganizationId
			And   oa.OrderTypeId = @OrderTypeId

End Try  
Begin Catch
		-- Roll back any active or uncommittable transactions before
		--If Xact_State() <> 0
		--	Rollback Transaction;
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
End Catch
