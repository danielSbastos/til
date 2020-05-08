## Different currencies with fluctuating exchange rates

TODO

```sh
ledger --price-db prices.db -V -f finances.ledger balance # -V to show in one currency and --price-db to apply current exchange rate in asset
ledger --price-db prices.db -f finances.ledger balance # no -V to show in all currencies
```
