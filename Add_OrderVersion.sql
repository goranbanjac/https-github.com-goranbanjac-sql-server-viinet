

CREATE Procedure [dbo].[Add_OrderVersion]
		 @Id						Int = null
		,@OrganizationId			Int
		,@OrderId					Int 
		,@OrderVersionAttribute		NVarchar (max)
		,@OrderTypeId				Int
		,@OrderDescription			NVarchar( 500 ) = null
		,@OrderNickname				NVarchar (500)  = null
		,@OrderConfiguration		NVarchar (max)  = null
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Add_OrderVersion
*
*	Description:
*			
*
*	PARAMETERS: 
*
* [dbo].[Add_OrderVersionG]
*		 @Id						Int = null
*		,@OrganizationId			Int
*		,@OrderId					Int 
*		,@OrderVersionAttribute		NVarchar (max)
*		,@OrderTypeId				Int
*		,@OrderDescription			NVarchar( 500 ) = null
*		,@OrderNickname				NVarchar (500)  = null
*		,@OrderConfiguration		NVarchar (max)	= ''
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i				 Int,
				@OrderVersionId  Int
				
			-- Register Instance of an order
				Merge	dbo.OrderOrganization q
					Using	(	select	 @Id, @OrganizationId, @OrderId, @OrderVersionAttribute, @OrderTypeId, @OrderDescription, @OrderNickname, @OrderConfiguration ) s 
							(	Id, OrganizationId, OrderId, OrderVersionAttribute, OrderTypeId, OrderDescription, OrderNickname, OrderConfiguration ) on 
								q.Id = s.Id
					When Matched 
						Then Update Set 	
										q.OrderVersionAttribute		= s.OrderVersionAttribute,
										q.OrderTypeId				= s.OrderTypeId,
										q.OrderDescription			= s.OrderDescription,
										q.OrderNickname				= s.OrderNickname,
										q.OrderConfiguration		= s.OrderConfiguration,
										q.EditedOn					= GetDate()			
					When Not Matched 
						Then Insert ( OrganizationId, OrderId, OrderVersionAttribute, OrderTypeId, OrderDescription, OrderNickname, OrderConfiguration )
							Values ( s.OrganizationId, s.OrderId, s.OrderVersionAttribute, s.OrderTypeId, s.OrderDescription, s.OrderNickname, s.OrderConfiguration  );

						--If @Id Is Null
							Select @OrderVersionId = IsNull(@Id,SCOPE_IDENTITY())
								Select @OrderVersionId OrderVersionId

	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch