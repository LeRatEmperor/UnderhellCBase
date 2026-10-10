# sql

**Realm:** Shared, Menu  ·  **Members:** 10

The SQL library allows you to access powerful database software included with Garry's Mod. It is the preferred and fastest method of storing large amounts of data. The database is located in sv.db serverside and cl.db clientside, both in the Garry's Mod base folder. SQL is a whole scripting language in itself although relatively simple, it's something you'll need to read up on before using this library.


Example of using sql.
```lua
-- Creating a table
sql.Query("CREATE TABLE my_db_table( id NUMBER , name TEXT )" )

-- Inserting a value to the table
sql.Query("INSERT INTO my_db_table( id , name ) VALUES( 1 , 'First') ")

-- Printing the tables data
PrintTable( sql.Query("SELECT * FROM my_db_table ") )

-- Deleting the table
sql.Query("DROP TABLE my_db_table") 
```

Known GMod [SQLite](https://www.sqlite.org/compile.html) settings:
* Temp files are stored in memory (`SQLITE_TEMP_STORE = 3`)
* No `ATTACH` and `DETACH` operations (`SQLITE_OMIT_ATTACH = 1`)
* No Virtual Tables (`SQLITE_OMIT_VIRTUALTABLE = 1`)
* No `VACUUM` operation (`SQLITE_OMIT_VACUUM = 1`)
* No `LIMIT` and `ORDER BY` clauses in `DELETE` and `UPDATE` statements (`SQLITE_ENABLE_UPDATE_DELETE_LIMIT`)

[wiki page](https://wiki.facepunch.com/gmod/sql)

### sql.Begin · Shared, Menu
`sql.Begin()`

Tells the engine a set of queries is coming. Will wait until [sql.Commit](https://wiki.facepunch.com/gmod/sql.Commit) is called to run them.
This is most useful when you run more than 100+ queries.
This is equivalent to :
```lua
sql.Query( "BEGIN;" )
```

[wiki](https://wiki.facepunch.com/gmod/sql.Begin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L91-L93)

---

### sql.Commit · Shared, Menu
`sql.Commit()`

Tells the engine to execute a series of queries queued for execution, must be preceded by [sql.Begin](https://wiki.facepunch.com/gmod/sql.Begin).

This is equivalent to `sql.Query( "COMMIT;" )`.

[wiki](https://wiki.facepunch.com/gmod/sql.Commit) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L99-L101)

---

### sql.IndexExists · Shared, Menu
`sql.IndexExists(indexName: string) → boolean`

Returns true if the index with the specified name exists.

**Arguments:**
- `indexName` (string) — The name of the index to check.

**Returns:**
- boolean — exists

[wiki](https://wiki.facepunch.com/gmod/sql.IndexExists) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L44-L50)

---

### sql.LastError · Shared, Menu
`sql.LastError() → string`

Returns the last error from a SQLite query.

**Returns:**
- string — Last error from SQLite database.

[wiki](https://wiki.facepunch.com/gmod/sql.LastError) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L107-L109)

---

### sql.Query · Shared, Menu
`sql.Query(query: string) → table|boolean|nil`

Performs a query on the local SQLite database, returns a table as result set, nil if result is empty and false on error.

**Arguments:**
- `query` (string) — The query to execute.

**Returns:**
- table|boolean|nil — `false` is returned if there is an error, `nil` if the query returned no data.

> **Warning:** To run SQL queries with this function safely, it is crucial to ensure that the concatenated variables in the query string are safe to avoid vulnerabilities like SQL injections. For this, it is recommended to use the [sql.SQLStr](https://wiki.facepunch.com/gmod/sql.SQLStr), which allows arguments to be escaped correctly.
> 
> It's best to just use [sql.QueryTyped](https://wiki.facepunch.com/gmod/sql.QueryTyped) instead if possible.

[wiki](https://wiki.facepunch.com/gmod/sql.Query)

---

### sql.QueryRow · Shared, Menu
`sql.QueryRow(query: string, row: number = 1) → table`

Performs the [sql.Query](https://wiki.facepunch.com/gmod/sql.Query) and returns the n'th row.

This function is equivalent to safely returning
```lua
sql.Query(query)[row]
```

**Arguments:**
- `query` (string) — The query as used in sql.Query
- `row` (number, default `1`) — The row number.

**Returns:**
- table — The returned row.

[wiki](https://wiki.facepunch.com/gmod/sql.QueryRow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L56-L66)

---

### sql.QueryTyped · Shared, Menu
`sql.QueryTyped(query: string, queryParams: vararg) → table|boolean`

Performs a query on the local SQLite database with proper type handling and parameter binding, returns a table as result set, empty table if no results, and false on error. Unlike [sql.Query](https://wiki.facepunch.com/gmod/sql.Query), this function properly handles SQLite data types and allows safe parameter binding to prevent SQL injection attacks.

**Arguments:**
- `query` (string) — The query to execute with optional `?` parameter placeholders.
- `queryParams` (vararg) — Parameters to bind to the query placeholders.

**Returns:**
- table|boolean — `false` is returned if there is an error (See sql.LastError), otherwise a table with properly typed column values (empty table if no results).

> **Warning:** * This function only executes a single SQL statement, unlike [sql.Query](https://wiki.facepunch.com/gmod/sql.Query) which can execute multiple statements separated by semicolons.
> 
> * Large INTEGER values (beyond ±9,007,199,254,740,991) are returned as strings to preserve exact values. This is because Lua represents all numbers as doubles, which lose precision for integers larger than 2⁵³-1. Returning them as strings prevents data corruption from rounding errors.

[wiki](https://wiki.facepunch.com/gmod/sql.QueryTyped)

---

### sql.QueryValue · Shared, Menu
`sql.QueryValue(query: string) → string`

Performs the query like [sql.QueryRow](https://wiki.facepunch.com/gmod/sql.QueryRow), but returns the first value found.

**Arguments:**
- `query` (string) — The input query.

**Returns:**
- string — The returned value.

[wiki](https://wiki.facepunch.com/gmod/sql.QueryValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L72-L85)

---

### sql.SQLStr · Shared, Menu
`sql.SQLStr(string: string, bNoQuotes: boolean = false) → string`

Escapes dangerous characters and symbols from user input used in an SQLite SQL Query.

If possible, it is recommended to use [sql.QueryTyped](https://wiki.facepunch.com/gmod/sql.QueryTyped) instead.

**Arguments:**
- `string` (string) — The string to be escaped.
- `bNoQuotes` (boolean, default `false`) — Set this as `true`, and the function will not wrap the input string in apostrophes.

**Returns:**
- string — The escaped input.

> **Warning:** Do not use this function with external database engines such as `MySQL`. `MySQL` and `SQLite` use different escape sequences that are incompatible with each other! Escaping strings with inadequate functions is dangerous and will lead to SQL injection vulnerabilities.

[wiki](https://wiki.facepunch.com/gmod/sql.SQLStr) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L9-L25)

---

### sql.TableExists · Shared, Menu
`sql.TableExists(tableName: string) → boolean`

Returns true if the table with the specified name exists.

**Arguments:**
- `tableName` (string) — The name of the table to check.

**Returns:**
- boolean — exists

[wiki](https://wiki.facepunch.com/gmod/sql.TableExists) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L33-L39)
