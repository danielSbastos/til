## Building indexes concurrently

When creating an index, all writes are blocked until the index is built, however, for large tables, this operation can take hours and hours, and if the database is production critical, you've got yourself on a tight situation. Thankfully, PostgreSQL provides a feature that can mitigate this by allowing writes while simultaneously creating the index, and that is the `CREATE INDEX CONCURRENTLY` command.

The way `CREATE INDEX CONCURRENTLY` works is by scanning the targeted table twice, the first to build the index with the current state (after waiting for all transactions to end) and the second to build upon with the modifications done while the first build was happening.

Some of the drawbacks are that this operation will take much longer than the non concurrent one, and that in case the index built fails, it will not delete it, but instead mark it as `INVALID` and keep updating it.

The following blogpost plays around with this feature and can lead you to more insights:
- https://blog.dbi-services.com/create-index-concurrently-in-postgresql/
