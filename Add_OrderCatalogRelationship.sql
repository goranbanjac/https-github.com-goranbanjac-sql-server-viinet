
CREATE Procedure [dbo].[Add_OrderCatalogRelationship]
			 @Id							int	= NULL		
			,@StrOrderCatalogId				NVarchar (4000)
			,@ParentOrderCatalogId			int = NULL
			,@ParentOrderTypeId				int = NULL
AS
Set Nocount On
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 11/16/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_OrderCatalogRelationship
*
*	Description:
*			
*
*	PARAMETERS: 
*			 @Id					int	= NULL			
*			,@OrderCatalogId		int	= NULL
*			,@ParentOrderCatalogId	int = NULL
*			,@SortOrder				tinyint = NULL
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int,
				@OrderCatalogRelationshipId Int,
				@ParetntId Int

				If @ParentOrderTypeId = 2
					Exec [dbo].[Add_OrderSet]
							 @Id					= null
							,@StrOrderCatalogId		= @StrOrderCatalogId
							,@OrderSetId			= @ParentOrderCatalogId

				If @ParentOrderTypeId = 3
					Exec [dbo].[Add_ActivitySet]
							 @Id					= null
							,@StrOrderCatalogId		= @StrOrderCatalogId
							,@ActivitySetId			= @ParentOrderCatalogId

				If @ParentOrderTypeId = 1
					Exec [dbo].[Add_PathwaySet]
							 @Id					= null
							,@StrOrderCatalogId		= @StrOrderCatalogId
							,@PathwayId				= @ParentOrderCatalogId

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0


