# Jenkins新規ジョブ作成手順

## 目次
- [Jenkins新規ジョブ作成手順](#jenkins新規ジョブ作成手順)
  - [目次](#目次)
  - [はじめに](#はじめに)
  - [新規ジョブ作成手順](#新規ジョブ作成手順)
      - [ジョブの作成](#ジョブの作成)
      - [ジョブの設定](#ジョブの設定)
      - [ビルド（バッチの指定または作成）](#ビルドバッチの指定または作成)

## はじめに
ビルドにJenkinsを社内プロジェクトで使用する事が多くなってきたがジョブを作成できるメンバーが少ないため手順書を作成しました。
基本的にsvnプロジェクトの方が多いためSVNのC#ターゲットに記述していますが、Gitもほぼ同じように対応できます。

## 新規ジョブ作成手順

#### ジョブの作成
1. [Jenkinsホーム] > [ダッシュボード] > [新規ジョブ作成]  を押下
1. [ジョブ名を入力] にジョブを入力
1. [フリースタイル・プロジェクトのビルド]を選択
1. 別プロジェクトをベースにする場合は[コピー元]に既存ジョブを入力

#### ジョブの設定
1. 説明に用途等を入力
1. ビルドのパラメータ化（任意）
   - Jenklins内にバッチコマンドを書き込む場合にチェックすると変数を定義できる
   - 任意入力、選択値、真偽値、パスワードなどを設定可能
   - [名前]でkeyを設定、[デフォルト値]でvalueの初期値を設定可能、推奨変数は以下の通り
       - リビジョン： [名前] Revision [デフォルト値] HEAD
        (指定のリビジョンをビルドしたい場合、実行時Subversionのリビジョン番号を入力)
       - ブランチ指定：[名前] Target_Brunch [選択値]ブランチ名 
1. ソースコード管理
   - SVN を選択し［RepositoryURL］と必要に資格情報を指定する
   - ［Ignore externals］:ビルドプロセス中にこれらの外部リソースを無視したい場合チェック
   - [Cancel process on externals fail] 外部ディレクトリのチェックアウトに失敗した場合全体をキャンセルする（推奨）
   - チェックアウト方式：以下を推奨
     クリーンチェックアウトのエミュレート（管理されていない/無視するファイルを最初に削除して'svn update'を実行）
   - リポジトリブラウザ：自動
2. ビルド環境
    - [秘密テキストや秘密ファイルを使用する] を選択し認証情報を入力する

#### ビルド（バッチの指定または作成）
- リポジトリ内のバッチファイルを呼び出す場合はcallコマンドとバッチ名のみ記述するとよい
- Windowsバッチコマンドの実行にバッチコマンドを入力可能
- %%内にはUIの選択値や本プロジェクトのグローバルパラメータを指定できる
```
REM @echo off
@echo on

ECHO メンバ変数
SET SOLUTION_PATH=%WORKSPACE%\{directoryName1/solutionName.sln}
SET BIN_DIR=%WORKSPACE%\{directoryName1\directoryName2\bin\Release\net6.0\publish}
SET PUBLISH_COPY_DIR=C:\{exportDirectoryName1\exportDirectoryName2}

REM SDKバージョンの確認
"C:\Program Files\dotnet\dotnet.exe" --version

ECHO ビルドコマンド実行
"C:\Program Files\dotnet\dotnet.exe" publish -c Release %SOLUTION_PATH%
if ERRORLEVEL 1 EXIT /b

ECHO フォルダ削除
rmdir /S /Q %PUBLISH_COPY_DIR%
ECHO 待機
ping 1.0.0.0 -w 5000 -n 1

mkdir %PUBLISH_COPY_DIR%

ECHO 無視リスト作成
ECHO appsettings.Development.json >> NoCopyList.txt
ECHO appsettings_release.json >> NoCopyList.txt
ECHO appsettings.json >> NoCopyList.txt
ECHO Web.Debug.config >> NoCopyList.txt
ECHO Web.Release.config >> NoCopyList.txt
ECHO nlog.config >> NoCopyList.txt

ECHO publishフォルダをディレクトリ構造ごとコピー
xcopy %BIN_DIR% %PUBLISH_COPY_DIR% /exclude:NoCopyList.txt /y/s/e/i

ECHO リビジョン情報
cd /d %PUBLISH_COPY_DIR%
ECHO %SVN_URL% >> BuildInfo.txt
ECHO %BUILD_NUMBER% >> BuildInfo.txt
ECHO %SVN_REVISION% >> BuildInfo.txt
```



