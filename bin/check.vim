call setline(1, 'version=' .. printf('%d.%d.%04d', v:version/100, v:version%100, v:versionlong%10000))
call setline(2, 'kaoriya=' .. has('kaoriya'))
