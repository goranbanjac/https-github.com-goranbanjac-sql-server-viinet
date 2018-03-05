
-- ONLY TO USE FOR SAME ORGANIZATION

CREATE Procedure [dbo].[ReUse_OrderSet]
		  @OrganizationId			Int
		 ,@OrderSetInstanceId		Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Add_OrderSet
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @Id						int	= null
*		,@OrganizationId			int
*		,@StrOrderCatalogId			Varchar (1000)
*		,@OrderSetId				Int
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i						Int,
				@OrderSetVerzionId		Int,
				@OrderId				Int,
				@OrderVersionAttribute	Varchar (max),
				@OrderDescription		Varchar (500),
				@OrderNickname			Varchar (500),
				@OrderConfiguration		Varchar (max)

				Select  
					@OrderId				= OrderId,
					@OrderVersionAttribute	= OrderVersionAttribute,
					@OrderDescription		= OrderDescription,
					@OrderNickname			= OrderNickname,
					@OrderConfiguration		= OrderConfiguration
				from dbo.OrderOrganization
				Where Id = @OrderSetInstanceId


				Declare @p table ( OrderSetVerzionId Int )
				Insert  @p ( OrderSetVerzionId )
				Exec [dbo].[Add_OrderVersion]  null, @OrganizationId ,@OrderId, @OrderVersionAttribute, 2, @OrderDescription, @OrderNickname, @OrderConfiguration

				Select @OrderSetVerzionId = OrderSetVerzionId from @p

			Declare @t Table ( Id int )
			Insert @t ( Id ) 
			Select OrderId
			From dbo.OrderSet
			Where OrderSetId = @OrderSetInstanceId

				Insert dbo.OrderSet
					( OrderSetId, OrderId )
				Select
					 @OrderSetVerzionId, Id  
				From @t
 
	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch

