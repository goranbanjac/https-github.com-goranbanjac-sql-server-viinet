
CREATE Procedure [dbo].[Add_OrderSet]
		  @Id						int	= null
		 ,@StrOrderCatalogId		NVarchar (4000)
		 ,@OrderSetId				Int
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
*		,@StrOrderCatalogId			NVarchar (1000)
*		,@OrderSetId				Int
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i					Int

			Declare @t Table ( Id int )
			Insert @t ( Id ) Select value From dbo.SplitStrings_Native (@StrOrderCatalogId , ',' ) 

			If Exists ( Select 1 From dbo.OrderSet where OrderSetId = @OrderSetId )
				Delete dbo.OrderSet Where OrderSetId = @OrderSetId
					
				Insert dbo.OrderSet
					( OrderSetId, OrderId )
				Select
					 @OrderSetId, Id  
				From @t
					
	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch



