
CREATE Procedure [dbo].[Copy_PathwayOld]
		  @NewOrganizationId		int
		 ,@PathwayInstanceId		Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Copy_Pathwa
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		  @Id						int	= null
*		 ,@NewOrganizationId		int
*		 ,@StrOrderCatalogId		Varchar(4000)
*		 ,@PathwayId				Int
*		 ,@OrderSetAttribute		Varchar(max) = ''
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i						Int,
				@PathwayVerzionId		Int,
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
				Where Id = @PathwayInstanceId

				Declare @p table ( PathwayVerzionId Int )
				Insert  @p ( PathwayVerzionId )
				Exec [dbo].[Add_OrderVersion]  null, @NewOrganizationId ,@OrderId, @OrderVersionAttribute, 1, @OrderDescription, @OrderNickname, @OrderConfiguration

				Select @PathwayVerzionId = PathwayVerzionId from @p

				Declare @t Table ( Id int )
				Insert @t ( Id ) 
				Select ActivityId 
				From dbo.PathwaySet
				Where PathwayId = @PathwayInstanceId

				
				Insert dbo.PathwaySet
					( PathwayId, ActivityId )
				Select
					 @PathwayVerzionId, Id  
				From @t
				
	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch

