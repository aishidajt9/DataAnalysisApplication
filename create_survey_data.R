# 社会学調査の仮想データ作成
# n=1000のデータセットを作成し、リサンプリングでn=500のデータも作成
#
# 変数の説明:
# - id: 回答者ID
# - age: 年齢（連続変数、20-69歳）
# - gender: 性別（男、女）
# - education: 学歴（中卒、高卒、大卒）
# - marital_status: 婚姻状態（既婚、未婚）
# - income: 収入（万円、連続変数）
# - happiness: 幸福感（0-10の整数）
# - class_identity: 階層帰属意識（0-10の整数）

library(tidyverse)

set.seed(123)  # 再現性のため

# サンプルサイズ
n <- 1000

# 独立変数の生成
age <- round(rnorm(n, mean = 45, sd = 15))
age <- pmax(20, pmin(age, 69))  # 20-69歳に制限

gender <- sample(c("男", "女"), n, replace = TRUE, prob = c(0.48, 0.52))

education <- sample(c("中卒", "高卒", "大卒"), n, replace = TRUE,
                    prob = c(0.15, 0.50, 0.35))

marital_status <- sample(c("既婚", "未婚"), n, replace = TRUE,
                         prob = c(0.60, 0.40))

# 収入（万円）: 学歴と年齢に関連
income_base <- case_when(
  education == "中卒" ~ rnorm(n, 300, 80),
  education == "高卒" ~ rnorm(n, 400, 100),
  education == "大卒" ~ rnorm(n, 550, 120)
)
income <- income_base + (age - 45) * 2  # 年齢効果
income <- round(pmax(150, income), 0)  # 最低150万円

# 従属変数1: 幸福感（0-10）
# 収入、婚姻状態、年齢が影響
happiness_score <- 5 +
  0.003 * income +
  ifelse(marital_status == "既婚", 1.2, 0) +
  ifelse(gender == "女", 0.3, 0) +
  rnorm(n, 0, 1.5)
happiness <- round(pmax(0, pmin(happiness_score, 10)), 0)

# 従属変数2: 階層帰属意識（0-10）
# 収入、学歴が強く影響
class_score <- 3 +
  0.005 * income +
  case_when(
    education == "中卒" ~ -0.5,
    education == "高卒" ~ 0,
    education == "大卒" ~ 1.2
  ) +
  rnorm(n, 0, 1.5)
class_identity <- round(pmax(0, pmin(class_score, 10)), 0)

# tibble作成
survey_data <- tibble(
  id = 1:n,
  age = age,
  gender = gender,
  education = education,
  marital_status = marital_status,
  income = income,
  happiness = happiness,
  class_identity = class_identity
)

# n=1000のデータを保存
write.csv(survey_data, "report_data.csv", row.names = FALSE, fileEncoding = "UTF-8")


# データの概要を表示
cat("=== n=1000 データの概要 ===\n")
print(summary(survey_data))
