# JavaScript方式アーカイブ

## 復活方法
```bash
cp archive/javascript-method/fix-toc.html .
cp archive/javascript-method/_output.yml .
cp archive/javascript-method/_bookdown.yml .
```

## この方式の特徴
- ブラウザでページ読み込み時にJavaScriptでTOC修正
- `_output.yml`の`after_body: fix-toc.html`でJavaScript挿入
- bookdown 0.44 + pandoc 3.7互換性問題の回避策

## アーカイブ日時
2025-09-11 15:30頃 - 動作確認済みの状態