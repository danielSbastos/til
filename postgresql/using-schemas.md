## Using schemas

This is simple but it was new to me :)

*List Schemas*
```psql
\dn
```

*List schemas tables*
```
\dt schema-name.
```

*Access table under schema*
```psql
SELECT field FROM schema-name.table-name;
```
