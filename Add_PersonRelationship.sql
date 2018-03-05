
CREATE Procedure [dbo].[Add_PersonRelationship]
			 @PersonId					Int
			,@StrPersonRelationshipId	NVarchar(100)	
AS
Set Nocount On
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/26/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PersonRelationship
*
*	Description:
*			
*
*	PARAMETERS: 
*			 @PersonId					Int
*			,@StrPersonRelationshipId	NVarchar(100)
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

			If Exists ( 
						Select 1 From dbo.PersonRelationship 
								Where PersonId = @PersonId	
								And PersonRelationshipId in ( Select Value From dbo.SplitStrings_Native ( @StrPersonRelationshipId, ',' ))   
								OR PersonId in ( Select Value From dbo.SplitStrings_Native ( @StrPersonRelationshipId, ','  ))  
								And PersonRelationshipId = @PersonId
					  )

						Throw 50001, N'This relationship already exist', 1

				Insert dbo.PersonRelationship ( PersonId, PersonRelationshipId ) 
				Select @PersonId, Value From dbo.SplitStrings_Native ( @StrPersonRelationshipId, ','  )

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0
