 
CREATE Procedure [dbo].[Get_ParentByVersionAndTypeId]
			@OrderVersionId		Int,
			@ParentOrderTypeId	Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 8/2/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_SetByVersionTypeId
*
*	Description:
*			
*
*	PARAMETERS: 
*			@OrderVersionId Int,
*			@OrderTypeId	Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int;
		Declare @t table ( Id int, OrderTypeId Int )

		If @ParentOrderTypeId = 4
			Insert @t ( Id, OrderTypeId )
			Select @OrderVersionId, @ParentOrderTypeId 
			
		
		If 	@ParentOrderTypeId = 1
			Begin
				with cte as
					(
							Select os.PathwayId Id, 1 as OrderTypeId
							from dbo.PathwaySet os 
							where ActivityId = @OrderVersionId
					)

					 Insert @t ( Id, OrderTypeId )
					 Select Id, OrderTypeId from cte
			End

		If 	@ParentOrderTypeId = 3
			Begin
				with cte as
					(
							Select os.ActivitySetId Id, 3 as OrderTypeId
							from dbo.ActivitySet os 
							where OrderSetId = @OrderVersionId
					)

					 Insert @t ( Id, OrderTypeId )
					 Select Id, OrderTypeId from cte
			End

			If 	@ParentOrderTypeId = 2
			Begin
				with cte as
					(
							Select os.OrderSetId Id, 2 as OrderTypeId
							from dbo.OrderSet os 
							where OrderId = @OrderVersionId
					)

					 Insert @t ( Id, OrderTypeId )
					 Select Id, OrderTypeId from cte
					 
			End

			Select distinct
					oa.Organizationid,
					t.OrderTypeId,
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
			From @t t
			Inner Join dbo.OrderOrganization oa On
				t.Id = oa.Id
			Inner Join dbo.OrderCatalog o On
				oa.OrderId = o.Id
			Order By OrderTypeId Asc
			--Where oa.Id = @OrderVersionId
				
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

