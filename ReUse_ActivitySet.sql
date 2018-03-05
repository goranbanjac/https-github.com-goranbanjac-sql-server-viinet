
CREATE Procedure [dbo].[ReUse_ActivitySet]
		 @OrganizationId			int
		,@ActivitySetInstanceId		Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.ReUse_ActivitySet
*
*	Description:
*			
*
*	PARAMETERS: 
*
* Exec [dbo].[Add_OrderCatalog]
*		  @Id						int	= null
*		 ,@OrganizationId			int
*		 ,@StrOrderCatalogId		Varchar (1000)
*		 ,@ActivitySetId			Int
*		 ,@OrderSetAttribute		Varchar (max)
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i						Int,
				@ActivityVerzionId		Int,
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
				Where Id = @ActivitySetInstanceId

				Declare @p table ( ActivityVerzionId Int )
				Insert  @p ( ActivityVerzionId )
				Exec [dbo].[Add_OrderVersion]  null, @OrganizationId, @OrderId, @OrderVersionAttribute, 3, @OrderDescription, @OrderNickname, @OrderConfiguration

				Select @ActivityVerzionId = ActivityVerzionId from @p

				Declare @t Table ( Id int )
				Insert @t ( Id ) 
				Select OrderSetId 
				From dbo.ActivitySet
				Where ActivitySetId = @ActivitySetInstanceId

		
				--If Exists ( Select 1 From dbo.ActivitySet where ActivitySetId = @ActivitySetId and OrderSetId in ( Select Id From @t ))
				--	Throw 50001, N'One or more order sets are already associated with this activity', 1

				Insert dbo.ActivitySet
					( ActivitySetId, OrderSetId )
				Select
					 @ActivityVerzionId, Id  
				From @t 

	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
			Throw;
				Return @i
	End Catch


