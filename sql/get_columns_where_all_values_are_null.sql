declare @col varchar(255), @cmd varchar(max), @table varchar(255)

set @table = 'Member'

DECLARE getinfo cursor for
SELECT c.name FROM sys.tables t JOIN sys.columns c ON t.Object_ID = c.Object_ID
WHERE t.Name = @table

OPEN getinfo

FETCH NEXT FROM getinfo into @col

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @cmd = 'IF NOT EXISTS (SELECT top 1 * FROM '+ @table +' WHERE [' + @col + '] IS NOT NULL) BEGIN print ''' + @col + ''' end'
    EXEC(@cmd)

    FETCH NEXT FROM getinfo into @col
END

CLOSE getinfo
DEALLOCATE getinfo