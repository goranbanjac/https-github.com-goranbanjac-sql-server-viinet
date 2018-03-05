
Create Procedure [dbo].[Get_FileDataById]
			 @Id	Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 02/08/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Get_FileDataById
*
*	Description:
*			
*
*	PARAMETERS: 
*
* [dbo].[Add_OrderVersionG]
*			 @Id	Int
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i	Int			

			Select
				 [FileName],[Location],[MimeType],[Details]
			From dbo.FileData 
			Where Id = @Id

	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch