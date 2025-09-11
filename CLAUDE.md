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
- **TOC修正**: `fix_toc_direct.R` （自動実行）

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
13-14. **レポート分析実習**

## ⚙️ TOCナビゲーション設定（重要）

### 現在の動作原理
bookdown 0.44 + pandoc 3.7 の互換性問題により、章4以降のTOCリンクが正しく生成されないため、HTML直接書き換えで修正しています。

### 設定ファイル

**`_output.yml`**:
```yaml
bookdown::gitbook:
  css: style.css
  split_by: rmd              # Rmdファイル名ベースでHTML生成
  toc_depth: 1               # 章レベル（レベル1）のみ表示
  config:
    toc:
      collapse: none         # 折りたたみ機能無効化
      scroll_highlight: yes
      before: |
        <li><a href="./">2025データ分析応用</a></li>
      after: |
        <li><a href="https://github.com/rstudio/bookdown" target="blank">Published with bookdown</a></li>
```

**`_bookdown.yml`**:
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

### TOC修正スクリプト

**`fix_toc_direct.R`** - data-level属性を使用した確実な修正:
```r
level_to_file <- list(
  "1" = "index.html",
  "2" = "01-descritive.html",
  "3" = "02-inference.html", 
  "4" = "03-linear_algebra_1.html",
  "5" = "04-linear_algebra_2.html",
  "6" = "05-single_regression_1.html",
  "7" = "06-single_regression_2.html",
  "8" = "07-multi-regression_1.html",
  "9" = "08-multi-regression_2.html",
  "10" = "09-multi-regression_3.html",
  "11" = "10-logistic-regression_1.html",
  "12" = "11-logistic-regression_2.html"
)
```

## 🔧 開発環境

### 必要なRパッケージ
```r
install.packages(c("bookdown", "tidyverse", "gganimate", "rgl"))
```

### Git設定
- **ソースリポジトリ**: `aishidajt9/DataAnalysisApplication` (main)
- **公開リポジトリ**: `aishidajt9/aishidajt9.github.io` (master)

## 🔄 /publishコマンドの動作

1. **レンダリング**: `bookdown::render_book()`
2. **TOC修正**: `Rscript fix_toc_direct.R` （156個のリンク修正）
3. **Git操作**: ソース→main、公開→master に自動プッシュ
4. **結果**: https://aishidajt9.github.io/DataAnalysisApplication/ が更新

## 🚨 トラブルシューティング

### 解決済みの問題
✅ 左サイドバーTOCリンクが正常動作（全12章）  
✅ 章レベルのみの一貫した表示（サブセクション非表示）  
✅ 重複HTMLファイル問題解決  
✅ bookdown 0.44 + pandoc 3.7互換性問題解決  

## 🔮 将来のメンテナンス

### TOC修正が不要になる条件
bookdown/pandocの互換性問題が修正され、`split_by: rmd`で正しい`data-path`属性が生成されるようになった場合

### 確認方法
```bash
# 1. TOC修正を無効にしてテスト
Rscript -e "bookdown::render_book()"

# 2. 結果を確認
grep "data-path" "../aishidajt9.github.io/DataAnalysisApplication/index.html"
```

### 期待される修正後の状態
- 章4以降も`data-path="index.html"`ではなく正しいHTMLファイル名
- アンカーリンクではなく直接ファイルリンクが生成

### 確認タイミング
- bookdown/pandocパッケージ更新時
- 新しいR環境セットアップ時

### 不要になった場合の手順
```bash
# publishコマンドから "Rscript fix_toc_direct.R &&" を削除
# fix_toc_direct.R をarchiveに移動
mv fix_toc_direct.R archive/
```

---

## 📝 まとめ

このプロジェクトは`/publish`コマンド一つで、レンダリング→TOC修正→Git操作→公開まで完全自動化されています。TOC修正は現在のbookdown/pandoc環境での一時的なワークアラウンドであり、将来的には不要になる可能性があります。