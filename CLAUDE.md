# データ分析応用講義プロジェクト

## プロジェクト概要
関西学院大学社会学部の「データ分析（応用）」講義のためのbookdownプロジェクトです。担当は石田淳教授。多変量解析（重回帰分析・ロジスティック回帰分析）をRで学習します。

## プロジェクト構造
- **メインファイル**: `index.Rmd`（タイトルページ）、`01-11-*.Rmd`（各章ファイル）
- **設定ファイル**: `_bookdown.yml`, `_output.yml`
- **参考文献**: `packages.bib`
- **出力**: HTML/PDF形式の電子書籍

## 講義内容
1. イントロダクション・R環境構築
2. 記述統計の復習
3. 推測統計の復習
4-5. 線形代数の基礎
6-7. 単回帰分析
8-10. 重回帰分析
11-12. ロジスティック回帰分析
13-14. レポート分析実習

## 書籍のビルド
```r
bookdown::render_book()
```

出力先: `../aishidajt9.github.io/DataAnalysisApplication/` (GitHub Pages用)

## ウェブ公開
- 公開URL: https://aishidajt9.github.io/DataAnalysisApplication/
- GitHubリポジトリ: aishidajt9/DataAnalysisApplication

## 開発コマンド
- **書籍ビルド**: `bookdown::render_book()`
- **クリーンビルド**: `bookdown::clean_book()`

## 重要なファイル
- 全ての`.Rmd`章ファイル（01-11章）
- 設定ファイル（`_*.yml`）
- 参考文献ファイル（`packages.bib`）
- プロジェクト説明（`README.md`）

## 無視すべきファイル
- 生成されたHTMLファイル（`.html`）
- ビルド成果物（`_bookdown_files/`, `_main_files/`）
- R履歴ファイル（`.Rhistory`）
- 一時ファイル（`tmp.R`）

## 一連の公開作業手順

### 1. レンダリング
```r
bookdown::render_book()
```
- 全ての.Rmdファイルが処理され、GitHubPages用ディレクトリに出力される
- 出力先: `../aishidajt9.github.io/DataAnalysisApplication/`

### 2. Git管理
```bash
git status              # 変更状況確認
git add .               # 全変更をステージング
git commit -m "コミットメッセージ"  # 変更をコミット
git push origin main    # リモートリポジトリに反映
```

### 3. ウェブサイト確認
- GitHubPagesが自動更新される
- URL: https://aishidajt9.github.io/DataAnalysisApplication/

### 必要なRパッケージ
- `bookdown`
- `tidyverse` 
- `gganimate`
- `rgl`