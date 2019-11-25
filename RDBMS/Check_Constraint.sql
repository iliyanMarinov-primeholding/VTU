USE [dbHotel]
GO

ALTER TABLE [dbo].[PhoneInfo]  WITH CHECK ADD  CONSTRAINT [CK_PhoneInfo_Phone_Len]
CHECK  ((len(Trim( ' ,.<>/?;'':"[]\{}|`~!@#$%^&*()_+-='+char(10)+char(13) FROM [PhonenNumber]))>(0)))
GO

ALTER TABLE [dbo].[PhoneInfo] CHECK CONSTRAINT [CK_PhoneInfo_Phone_Len]
GO

select len(' FF ')
select len('	')
select len(char(13)+char(10))
select (char(13)+char(10))

select quoteName((' FF '), '|')
select quoteName(ltrim(' FF '))
select quoteName(Rtrim(' FF '))
select quoteName(trim( '()/\[]{}.,12.,12.,31.654' from '654654654654..12.3.123.13!@#!@@FF'))
select ascii(null)
select ascii([value]), [value] from string_split('6,5,4,6,5,4,6,5,4,6,5,4,.,.,1,2,.,,3,.,1,2,3,.,1,3,!,@,,#,!,@,@,F,F,', ',')

