
CREATE Procedure [dbo].[Add_VideoAttributes]
			@Fps Decimal(10,2),
			@Bitrate Decimal(10,2),
			@Size Int ,
			@Duration Decimal(10,2) ,
			@Width Int ,
			@Height Int  ,
			@Filename NVarchar(100)
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 01/11/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Add_VideoAttributes
*
*	Description:
*			
*
*	PARAMETERS: 
*
*			@Fps Decimal(10,2),
*			@Bitrate Decimal(10,2),
*			@Size Int NOT NULL,
*			@Duration Decimal(10,2) ,
*			@Width Int ,
*			@Height Int  ,
*			@Filename NVarchar(100)
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i	Int

			Insert dbo.VideoAttributes ( Fps, Bitrate, Size, Duration, Width,Height, [Filename]) 
			Values ( @Fps, @Bitrate, @Size, @Duration, @Width, @Height, @Filename ) 
					
	End Try  
	Begin Catch
	-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch
