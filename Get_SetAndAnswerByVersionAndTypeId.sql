 
CREATE Procedure [dbo].[Get_SetAndAnswerByVersionAndTypeId]
			@OrderVersionId Int,
			@OrderTypeId	Int
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

		If @OrderTypeId = 4
			Insert @t ( Id, OrderTypeId )
			Select @OrderVersionId, @OrderTypeId 
			
			
		If 	@OrderTypeId = 1
			Begin
				with fte as
					(
							Select PathwayId, ActivityId
							from dbo.PathwaySet 
							where PathwayId = @OrderVersionId
					),
					cte as
					(
							Select PathwayId Id, 1 as OrderTypeId
							from fte
							where PathwayId = @OrderVersionId
							Union All
							Select  ActivityId Id, 3 as OrderTypeId
							from fte
							where PathwayId = @OrderVersionId
					),
					bte as
					 (
							Select  OrderSetId Id , 2 as OrderTypeId
							from dbo.ActivitySet 
							where ActivitySetId in (select Id From cte where OrderTypeId = 3 )
					 ),
					 dte as
					 (
							Select  OrderId Id , 4 as OrderTypeId
							from dbo.OrderSet 
							where OrderSetId in (select Id From bte where OrderTypeId = 2 )
					 )

					 Insert @t ( Id, OrderTypeId )
					 Select Id, OrderTypeId from cte
					 Union 
					 Select Id, OrderTypeId from bte
					 Union 
					 Select Id, OrderTypeId from dte
			End

		If 	@OrderTypeId = 3
			Begin
				with fte as
					(
							Select ActivitySetId, OrderSetId
							from dbo.ActivitySet 
							where ActivitySetId = @OrderVersionId
					), 
					cte as
					(
							Select ActivitySetId Id, 3 as OrderTypeId
							from fte
							where ActivitySetId = @OrderVersionId
							Union All
							Select  OrderSetId Id, 2 as OrderTypeId
							from fte
							where ActivitySetId = @OrderVersionId
					),
					bte as
					 (
							Select  OrderId Id , 4 as OrderTypeId
							from dbo.OrderSet 
							where OrderSetId in (select Id From cte where OrderTypeId = 2 )
					 )

					 Insert @t ( Id, OrderTypeId )
					 Select Id, OrderTypeId from cte
					 Union 
					 Select Id, OrderTypeId from bte
			End

			If 	@OrderTypeId = 2
			Begin
				with fte as
					(
							Select OrderSetId, OrderId
							from dbo.OrderSet 
							where OrderSetId = @OrderVersionId
					), 
				cte as
					(
							Select OrderSetId Id, 2 as OrderTypeId
							from fte 
							where OrderSetId = @OrderVersionId
							Union All
							Select  OrderId Id, 4 as OrderTypeId
							from fte
							where OrderSetId = @OrderVersionId
					)

					 Insert @t ( Id, OrderTypeId )
					 Select Id, OrderTypeId from cte	 
			End

			Select distinct
					oa.Organizationid,
					oa.Id OrderVersionId, 
					t.OrderTypeId,
					o.Id OrderId, 
					o.[Order],
					o.OrderCategoryId,
					o.AnswerVersionGroupId,
					ag.AnswerVersionGroup,
					ac.VersionChoicesName
			From @t t
			Inner Join dbo.OrderOrganization oa On
				t.Id = oa.Id
			Inner Join dbo.OrderCatalog o On
				oa.OrderId = o.Id
			Left Join dbo.AnswerVersionGroup ag On
				o.AnswerVersionGroupId = ag.Id
			Left Join dbo.AnswerVersionChoice ac On
				ag.Id = ac.AnswerVersionGroupId
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

