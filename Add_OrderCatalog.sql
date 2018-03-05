
CREATE Procedure [dbo].[Add_OrderCatalog]
		 @Id						int	= null
		,@OrganizationId			Int
		,@Order						NVarchar(255)
		,@OrderTypeId				tinyint 
		,@IsReusable				tinyint = 1
		,@OrderDescription			NVarchar( 500 ) = null
		,@OrderCategoryId			tinyint		  
		,@AnswerInputTypeId			NVarchar (50)	= Null
		,@OrderNickname				NVarchar (50)
		,@AnswerVersionGroupId		Int				= Null
		,@OrderConfiguration		NVarchar (max)	= NULL
		,@IsRequired				tinyint
		,@OrderAttribute			NVarchar (max)	= ''
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Add_OrderCatalog
*
*	Description:
*			
*
*	PARAMETERS: 
*
* Exec [dbo].[Add_OrderCatalog]
*		 @Id						= null
*		,@Order						= 'Order 8'
*		,@OrderTypeId				= 4
*		,@IsReusable				= 1
*		,@OrderDescription			= ''
*		,@OrderCategoryId			= 3
*		,@OrderNickname				= ''		  
*		,@AnswerInputTypeId			= 1
*		,@AnswerVersionGroupId		= 3
*		,@SortOrder					= 2
*		,@IsRequired				= 1
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i				Int,
				@OrderCheckSum	Int,
				@OrderCatalogId Int

			Select
				@OrderCheckSum	= 0,
				@OrderCatalogId = 0

			Select @OrderCheckSum = CheckSum(LTRIM(RTRIM(@Order)));

			If Exists ( Select 1 From dbo.OrderCatalog Where OrderCheckSum = @OrderCheckSum And Id <> IsNull(@Id,0))
					Throw 50001, N'This Order already exist', 1

					Merge	dbo.OrderCatalog q
					Using	(	select	 @Id,@OrderCheckSum,@Order,@OrderTypeId,@IsReusable,@OrderCategoryId,@AnswerInputTypeId,@AnswerVersionGroupId,@IsRequired ) s 
							(	Id,OrderCheckSum,[Order],OrderTypeId,IsReusable,OrderCategoryId,AnswerInputTypeId,AnswerVersionGroupId,IsRequired) on 
								q.Id = s.Id
					When Matched 
						Then Update Set 	
										q.OrderCheckSum				= s.OrderCheckSum			,
										q.[Order]					= s.[Order]					,
										q.OrderTypeId				= s.OrderTypeId				,
										q.IsReusable				= s.IsReusable				,
										q.OrderCategoryId			= s.OrderCategoryId			,
										q.AnswerInputTypeId			= s.AnswerInputTypeId		,
										q.AnswerVersionGroupId		= s.AnswerVersionGroupId	,
										q.IsRequired				= s.IsRequired				,
										q.EditedOn					= getdate()
					When Not Matched 
						Then Insert ( OrderCheckSum,[Order],OrderTypeId,IsReusable,OrderCategoryId,AnswerInputTypeId,AnswerVersionGroupId,IsRequired)
							Values ( s.OrderCheckSum,s.[Order],s.OrderTypeId,s.IsReusable,s.OrderCategoryId,s.AnswerInputTypeId,s.AnswerVersionGroupId,s.IsRequired);
							Select @OrderCatalogId = IsNull(@Id, SCOPE_IDENTITY()) 
						
						If @Id Is Null

							Exec [dbo].[Add_OrderVersion]  Null, @OrganizationId, @OrderCatalogId, @OrderAttribute, @OrderTypeId, @OrderDescription, @OrderNickname, @OrderConfiguration

	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		If Xact_State() <> 0
			Rollback Transaction;
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch


