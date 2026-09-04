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

## ⛔ 分析実習はbookdownで扱わない（厳守）

**分析実習は章にせず、去年（2025年度）と同じくLUNA配布で運用する。**
2026-09-04に明示的な指示。センシティブな内容を含むため公開サイトには載せない。

- **本のRmdとして実習章を作らない。** 2026年に一度 `13-practice.Rmd` を作ったが撤回し、
  `archive/13-practice.Rmd` に退避済み。復活させないこと
- `_bookdown.yml` の `rmd_files` は `12-logistic-regression_2.Rmd` までとする
- `report_data.csv` / `create_survey_data.R` はこのリポジトリで管理しない
  （`.gitignore` 済み。実体はDropboxの `report/` にある）
- 実習データをURL配布する案は却下済み

**公開範囲はロジスティック回帰分析(2)（第13章）まで。**

### 実習・最終リポートの運用（LUNA配布）

実体は Dropbox 側で管理する:
`2026年度授業関連/2026秋データ分析応用/report/`

| ファイル | 用途 |
|:---|:---|
| `最終リポートについて.md` | 課題文。LUNAに掲示 |
| `report_data.csv` | 実習データ（n=1000の合成データ）。LUNA配布 |
| `report_template.R` | 学生に配る雛形。データ読込とシード設定まで |
| `create_survey_data.R` | データ生成コード（`set.seed(123)`）。配布しない |
| `analysis_example.R` | 教員用の分析例。配布しない |

学生は `report_data.csv` と `report_template.R` をLUNAから取得し、
同じフォルダに置いて作業する（`read_csv("report_data.csv")` の相対パス前提）。

push前に混入がないか必ず確認する:
```bash
git diff --cached --name-only | grep -E "13-practice|report_data|create_survey"
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

## 📖 講義内容（公開資料は全13章）
1. **イントロダクション** - R環境構築
2. **記述統計の復習** - 基本統計量、相関係数
3. **推測統計の復習** - 検定、区間推定
4-5. **線形代数の基礎** - ベクトル（内積・直交）、行列演算・逆行列
6-8. **単回帰分析** - 最小二乗法、決定係数、推定・検定
9-11. **重回帰分析** - 偏回帰係数、多重共線性、ダミー変数
12-13. **ロジスティック回帰分析** - 一般化線形モデル

第14-15回の分析実習は資料を作らず、LUNA配布で運用する（上記「⛔」参照）。

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

### 受講者のインストール問題（既知・未解決）
2026年春のSDS入門で `install.packages()` が通らない学生が75名中3名発生した。
**管理者権限でRStudioを実行しても不可**のケースがあり、原因は特定できていない。
疑われたのはOneDriveのパス競合とウイルス対策ソフトのブロックだが、確定していない。

なお **OneDrive説は考えにくい**。R 4.2.0 (2022-04) 以降、Windowsの個人ライブラリは
`Documents` ではなく `%LOCALAPPDATA%/R/win-library/`（OneDrive同期対象外）に変わった
（CRAN R for Windows FAQ）。ネット上の「OneDriveでRが壊れる」記事は2020-2022年の
古い情報なので鵜呑みにしないこと。

index.Rmd の「うまくいかないときは」には、原因が不明なまま対処だけを症状ベースで
記載している（管理者として実行、ウイルス対策の一時停止、type="binary"、最後はColab）。
今年また発生したら、エラーメッセージ全文とセキュリティソフト名を控えておくと
来年以降の特定につながる。

春はbase Rのみの `.R` 版を並列配布して救済した。本科目はそもそも `.R` 運用だが
tidyverse必須のため、同じ手は使えない。Colabに逃がすのが早い。


### knitが途中で止まる（エラー表示なし）
→ ほぼ確実に `rgl`/XQuartz 問題。上記「rgl と XQuartz」を参照。

### PDFビルドがsegfault（exit 139）で落ちる
`08-multi-regression_1.Rmd` の `rgl` チャンクが原因。`options(rgl.printRglwidget = TRUE)`
はHTMLウィジェットを生成する設定なので、PDF出力時に呼ばれるとRごとクラッシュする。

**対処済み**: 当該チャンクに `eval = knitr::is_html_output()` を付け、PDFでは
3D図を出力しない（代わりに「HTML版で確認すること」の但し書きを表示）。

なお `rgl` のスナップショット（`rgl.snapshot()`）でPDFにも静止画を出す案は**使えない**。
CLI経由の `Rscript` にはDISPLAYがなくX11に接続できず、null deviceにフォールバックして
空の画像（311バイト）が出力される。XQuartzを入れてあってもGUIのRStudio以外では繋がらない。

### 解決済みの問題
✅ TOCリンク不正問題（bookdown 0.44 + pandoc 3.7）
   → bookdown 0.48 + pandoc 3.10 で解消を確認済み（2026-09-04）。
   ワークアラウンド `fix_toc_direct.R` は `archive/` に退避済み。
   万一TOCリンクが再び壊れた場合は `archive/fix_toc_direct.R` を復帰させる。
✅ `style.css` の参照切れ → `_output.yml` から削除
✅ `edit:` のプレースホルダURL → 正しいリポジトリURLに修正
