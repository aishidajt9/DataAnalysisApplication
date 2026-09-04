# データ分析応用講義プロジェクト

## プロジェクト概要
関西学院大学社会学部の「データ分析（応用）」講義のためのbookdownプロジェクトです。
- **担当**: 石田淳教授
- **内容**: 多変量解析（重回帰分析・ロジスティック回帰分析）をRで学習
- **公開URL**: https://aishidajt9.github.io/DataAnalysisApplication/

## 🚀 クイックスタート

### 公開まで一括実行
```bash
/publish [オプション：コミットメッセージ]
```

### 手動ビルド
```r
bookdown::render_book()
```

## 📁 プロジェクト構造

### 重要なファイル
- **章ファイル**: `index.Rmd`, `01-descritive.Rmd` ～ `11-logistic-regression_2.Rmd`
- **設定ファイル**: `_bookdown.yml`, `_output.yml`
- **退避済み**: `archive/fix_toc_direct.R` （TOC修正ワークアラウンド、現在は不要）

### 無視すべきファイル
- 生成HTMLファイル（`.html`）
- ビルド成果物（`_bookdown_files/`, `_main_files/`）
- 一時ファイル（`.Rhistory`, `tmp.R`）

## 📖 講義内容（全12章）
1. **イントロダクション** - R環境構築
2. **記述統計の復習** - 基本統計量、相関係数
3. **推測統計の復習** - 検定、区間推定
4-5. **線形代数の基礎** - ベクトル、行列演算
6-7. **単回帰分析** - 最小二乗法、決定係数
8-10. **重回帰分析** - 偏回帰係数、多重共線性
11-12. **ロジスティック回帰分析** - 一般化線形モデル
13-15. **分析実習** - Rによる回帰・ロジスティック回帰の実行

## ⚙️ ビルド設定

### `_output.yml`
```yaml
bookdown::gitbook:
  split_by: rmd              # Rmdファイル名ベースでHTML生成
  toc_depth: 1               # 章レベル（レベル1）のみ表示
  config:
    toc:
      collapse: none         # 折りたたみ機能無効化
      before: |
        <li><a href="./">2026データ分析応用</a></li>
```

### `_bookdown.yml`
`output_dir: "../aishidajt9.github.io/DataAnalysisApplication"` （相対パス）

**重要**: この相対パス指定のため、本リポジトリは `aishidajt9.github.io` と
**同じ親ディレクトリ（`~/Projects/`）に置く必要がある**。
Dropbox等に置くと出力先が解決できない。

## 🔧 開発環境

### 必要なRパッケージ
```r
install.packages(c("bookdown", "tidyverse", "gganimate", "rgl"))
```

### ⚠️ rgl と XQuartz（重要）

第7章（`07-multi-regression_1.Rmd`）の3D散布図は `rgl` を使う。
`rgl` は **XQuartz** に依存し、未インストールだと以下のエラーで
**knitがサイレントに停止する**（エラーメッセージが出ないまま終了コード0）:

```
unable to load shared object '.../rgl/libs/rgl.so':
Library not loaded: /opt/X11/lib/libGLU.1.dylib
```

**対処**:
```bash
brew install --cask xquartz   # 要 sudo。インストール後に再ログインが必要
```

XQuartzを入れられない環境で暫定ビルドする場合は、
`07-multi-regression_1.Rmd` の `plot3d`/`planes3d` を含むチャンクに
`eval = FALSE` を付ける（ただし3D図は出力されない）。

### 年度更新時の作業
1. `index.Rmd` の `title:` を新年度に更新
2. `_output.yml` の TOC `before:` のラベルを新年度に更新
3. `index.Rmd` の「講義スケジュール」節をシラバスに合わせて更新
4. 前年度分を残すため `git tag -a YYYY-final` を打ってpush

## 🔄 /publishコマンドの動作

1. **HTMLレンダリング**: `bookdown::render_book()`
2. **PDFレンダリング**: `bookdown::render_book(output_format = 'bookdown::pdf_book')`
3. **Git操作**: ソース→main、公開→master に自動プッシュ
4. **結果**: https://aishidajt9.github.io/DataAnalysisApplication/ が更新

## 🚨 トラブルシューティング

### knitが途中で止まる（エラー表示なし）
→ ほぼ確実に `rgl`/XQuartz 問題。上記「rgl と XQuartz」を参照。

### 解決済みの問題
✅ TOCリンク不正問題（bookdown 0.44 + pandoc 3.7）
   → bookdown 0.48 + pandoc 3.10 で解消を確認済み（2026-09-04）。
   ワークアラウンド `fix_toc_direct.R` は `archive/` に退避済み。
   万一TOCリンクが再び壊れた場合は `archive/fix_toc_direct.R` を復帰させる。
✅ `style.css` の参照切れ → `_output.yml` から削除
✅ `edit:` のプレースホルダURL → 正しいリポジトリURLに修正
