- ok
```
./cal_fee.sh < normal
```

- hh:mm:ss.fff<SPACE>xxxxxxxx.f<LF> ではなく、 正しいフォーマットでない
```
./cal_fee.sh < err_foramt
```

- 空行
```
./cal_fee.sh < err_blank
```

- 過去の時間が送られてきたとき
```
./cal_fee.sh < err_past
```

- レコードの間隔が5分以上開いてるとき
```
./cal_fee.sh < err_more
```
- トータルで2行未満のデータしかない
```
./cal_fee.sh < err_less
```
- 全体の走行距離が0.0メートルのとき
```
./cal_fee.sh < err_zero
```

