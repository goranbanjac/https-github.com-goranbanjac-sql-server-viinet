
CREATE Procedure [dbo].[Add_PathwaySet]
		  @Id						int	= null
		 ,@StrOrderCatalogId		NVarchar(4000)
		 ,@PathwayId				Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Add_PathwaySet
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		  @Id						int	= null
*		 ,@StrOrderCatalogId				Int
*		 ,@PathwayId				Int
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

				If Exists ( Select 1 From dbo.PathwaySet where PathwayId = @PathwayId )
					Delete dbo.PathwaySet Where PathwayId = @PathwayId

				Insert dbo.PathwaySet
					( PathwayId, ActivityId )
				Select
					 @PathwayId, Id 
				From @t

	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch
