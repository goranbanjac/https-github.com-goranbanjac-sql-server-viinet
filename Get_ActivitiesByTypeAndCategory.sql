
CREATE Procedure [dbo].[Get_ActivitiesByTypeAndCategory]
		 @OrganizationId	Int,
		 @OrderTypeId		Int,
		 @OrderCategoryId	Int
		
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Get_ActivitiesByTypeAndCategory
*
*	Description:	
*
*	PARAMETERS: 
*
*		 @Id					Int	= null
*		,@OrganizationId		Int,
*		,@OrderCategoryId		Int
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i	Int

			Declare @t Table
				( 
					Organizationid				Int,
					OrderId						Int, 
					[Order]						NVarchar(1000),
					IsReusable					Tinyint, 
					OrderDescription			NVarchar(1000),
					OrderCategoryId				Tinyint,
					OrderNickname				NVarchar(1000),
					AnswerInputTypeId			Tinyint,
					AnswerVersionGroupId		Int,
					OrderConfiguration			NVarchar(max),
					OrderVersionId				Int, 
					OrderVersionAttribute		NVarchar(max),
					OrderTypeId					Int
				)

			Insert
				@t
				(
					Organizationid				,
					OrderId						, 
					[Order]						,
					IsReusable					, 
					OrderDescription			,
					OrderCategoryId				,
					OrderNickname				,
					AnswerInputTypeId			,
					AnswerVersionGroupId		,
					OrderConfiguration			,
					OrderVersionId				, 
					OrderVersionAttribute		,
					OrderTypeId
				)

			Exec [dbo].[Get_OrderListByOrg]
					@OrganizationId	= @OrganizationId,
					@OrderTypeId	= @OrderTypeId

			Select * From @t 
			Where OrderCategoryId = @OrderCategoryId

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
