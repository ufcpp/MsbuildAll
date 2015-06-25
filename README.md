# MsbuildAll
リポジトリ内の sln に対して NuGet restore と msbuild を掛けて回るスクリプト。

## 前提

- NuGet パッケージを結構な数参照してる
  - プライベート パッケージも作る
- GitHub リポジトリ間で依存関係を持ってる
  - submodule 使うの面倒なので、同じフォルダー以下に全部のリポジトリを clone して使う想定
  - (以下、このフォルダーを「githubルート」と呼ぶ)
- プライベートな NuGet リポジトリを持ってる
  - githubルート直下に、`packages` というフォルダーを作って、そこをプライベートNuGetリポジトリにする

## 解決方針

- GitHubリポジトリ直下の`build`フォルダー以下に NuGet restor/msbuild 掛けスクリプトを置く
  - (すべてのGitHubリポジトリで)
- `build`フォルダー以下のスクリプトはほぼコピペで使える状態にする
  - 一部の設定だけを書き替えればOKの状態にする

## 設定(GitHubリポジトリごとに書き替えるもの)

- `solusions.txt`: GitHubリポジトリ中にあるソリューションファイルを、1行1ソリューションで記載(buildフォルダーからの相対パス)
- `dependency.txt`: 依存しているGitHubリポジトリ名を、1行1リポジトリで記載
- `postbuild.ps1`: (もし必要なら)ビルド後に実行するコマンドを記述

## このリポジトリの内容物

- buildフォルダー: 各GitHubリポジトリにコピペして使う(上記の設定だけ書き換え)
- それ以外: 利用例

### 利用例の動かし方

プライベートNuGetリポジトリの動作確認も兼ねているので、まず、 

- githubルート直下に `packages`フォルダーを作る
- 作った`packages`フォルダーに、`FluentArithmetic.1.0.0.0.nupkg` をコピーする

その後、`build`フォルダー内で`build.bat`を実行(Explorerからのダブルクリックでも可)。
