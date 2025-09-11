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

## Claude Code カスタムコマンド

### /publish コマンド
プロジェクトディレクトリで以下を実行：
```
/publish [オプション：コミットメッセージ]
```

このコマンドで以下が一括実行されます：
1. `bookdown::render_book()` でレンダリング
2. 変更をgitにコミット（タイムスタンプ付きまたは指定メッセージ）
3. ソースリポジトリにプッシュ
4. GitHub Pagesリポジトリにもプッシュ

コマンドファイル: `.claude/commands/publish.md`

## TOCナビゲーション設定（重要）

### 成功した設定（2025-09-11確認済み）

**`_output.yml` の正しい設定:**
```yaml
bookdown::gitbook:
  css: style.css
  split_by: rmd              # Rmdファイル名ベースでHTML生成
  toc_depth: 1               # 章レベル（レベル1）のみ表示
  includes:
    after_body: fix-toc.html # JavaScriptでdata-path修正
  config:
    toc:
      collapse: none         # 折りたたみ機能無効化
      scroll_highlight: yes
      before: |
        <li><a href="./">2025データ分析応用</a></li>
      after: |
        <li><a href="https://github.com/rstudio/bookdown" target="blank">Published with bookdown</a></li>
    edit: https://github.com/USERNAME/REPO/edit/BRANCH/%s
    download: ["pdf", "epub"]
    search:
      engine: fuse
      options: null
```

**`_bookdown.yml` の設定:**
```yaml
delete_merged_file: true
language:
  ui:
    chapter_name: ["第", "章"]
output_dir: "../aishidajt9.github.io/DataAnalysisApplication"
rmd_files:
  - "index.Rmd"
  - "01-descritive.Rmd"
  - "02-inference.Rmd"
  - "03-linear_algebra_1.Rmd"
  - "04-linear_algebra_2.Rmd"
  - "05-single_regression_1.Rmd"
  - "06-single_regression_2.Rmd"
  - "07-multi-regression_1.Rmd"
  - "08-multi-regression_2.Rmd"
  - "09-multi-regression_3.Rmd"
  - "10-logistic-regression_1.Rmd"
  - "11-logistic-regression_2.Rmd"
```

**重要な技術ポイント:**
- `split_by: rmd` でRmdファイル名ベースのHTML生成（`01-descritive.html`等）
- `toc_depth: 1` でサブセクション非表示を強制
- `collapse: none` で一貫した表示
- `fix-toc.html` でdata-path属性をJavaScriptで修正

### 解決した問題
1. ✅ 左サイドバーTOCリンクが正常動作
2. ✅ 章レベルのみの一貫した表示（サブセクション非表示）
3. ✅ 重複HTMLファイル問題解決
4. ✅ bookdown 0.44 + pandoc 3.7互換性問題解決

### 注意事項
- `fix-toc.html` ファイルが必須
- 設定変更時は必ず `bookdown::render_book()` で全体再ビルド
- GitHub Pagesブランチは `master` を使用