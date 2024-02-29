# ungoogled chromium

Install [ungoogled-chromium](https://github.com/ungoogled-software/ungoogled-chromium-debian)
browser.

TODO: use cromite
```shell
curl -L -s https://github.com/uazo/cromite/releases/download/v122.0.6261.64-26d88dcdf588ee60b5ba96d512cbfec525fb3d66/updateurl.txt \
  | awk '{split($0,a,";"); for (i in a) { if (a[i] ~ /^version/) {split(a[i],b,"="); print b[2]} } }'
```
