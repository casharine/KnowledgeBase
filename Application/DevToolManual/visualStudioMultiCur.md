Visual Studio のマルチカーソル練習帳
---
新入社員にVSCodeではなく、VS(.netのIDE)のマルチカーソルのショートカットを紹介しようにもまとめている記事がなく困っていました。私自身が使用するきっかけとなった以下出典がわかりやすいのでほぼ使い回します。

**出典**：[VSCodeのマルチカーソル練習帳](https://qiita.com/TomK/items/3b1f5be07d708d7bd6c5)
※ 編集ツール：[StackEdit](https://stackedit.io/)

![json2java.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/5294f1d8-863f-373a-2065-b6c85b0683fd.gif)

なお記事では、以下のテキストをサンプルとして使用しています。お手元にVSCodeを用意できる方は、サンプルを使って同じ操作を試しながら覚えてみてください！

```sample.json
{
  "id" : "12345678-1234-1234-1234-123456789012",
  "title" : "myTitle",
  "content" : "myContent",
  "createdAt" : "2019-09-01 00:00:00",
  "createdUser" : "12345678-1234-1234-1234-123456789012",
  "updatedAt" : "2019-09-01 00:00:00",
  "updatedUser" : "12345678-1234-1234-1234-123456789012"
}
```

---

# VSのマルチカーソル練習帳

VSのマルチカーソルをうまく使うには、3つのポイントを押さえる必要があります。

1. カーソル追加のポイント
2. カーソル移動のポイント
3. マルチカーソルを活用した編集のポイント

3つのポイントそれぞれについて、いくつかの操作の「ワザ」が存在します。ワザの組み合わせで、マルチカーソル編集を行います。

## カーソル追加のポイント

マルチカーソル編集を始めるきっかけとなる操作です。全く初めての方はとりあえず1つのワザだけ覚えて、便利さに触れてから他のワザを覚えるといいかもしれません。

### Alt + クリック / option + クリック

クリックした箇所にカーソルを1つずつ追加します。1つずつ追加するので手間がかかりますが、どんな場合でも対応できます。

![option_click.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/7fc42911-1353-08b5-b7fa-ddbb18d758ec.gif)


### マウス中ボタンドラッグ / Alt + Shift + ドラッグ / option + Shift + ドラッグ

矩形選択します。カーソルは縦一列に並ぶので、全行にまとめてカーソルを置きたい場合にはこちら。

![option_shift.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/3866fdba-ccd9-996c-69ed-c4e5d0f557d1.gif)

**(2021/02/18 追記) マウス中ボタン(ホイールボタン)でドラッグしても同様です。** 最近はこればっかり使っています。覚えることも少なくてお手軽！



### Alt + SHIFT + カーソル上下 

上または下の行に1つずつカーソルを追加します。前項と同じ
操作をキーボードから手を離さずできる感じです。

![option_command_cursor.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/2410d4ff-7c16-ca83-fa47-4044f79c525c.gif)

### Ctrl +  .

選択中のキーワードで文書を1件ずつ検索します。置換を使うまでもない軽微な修正なんかに使えます。
ちなみに __Ctrl + / -> Ctrl + . で検索結果を1件スキップします__ 。

![command_d.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/edc9d945-3e39-a64d-ec7e-c2e18ea96c37.gif)


## カーソル移動のポイント

マルチカーソルの移動も通常のカーソル移動と同じワザを使いますが、__長さの違う複数の文字列を狙った通りに選択する__ ことが重要になってきます。

### Shiftを押しながらで範囲選択

前提として、通常時と同じでShiftを押しながらでカーソル移動することで範囲選択します。以下の方法全てに対して組み合わせできます。

### 左右キー

当たり前っぽいですが、通常時と同じで左右キーで左右にカーソルを移動します。
同じ文字数ぶん移動するので、行末とかキーワードの先頭にカーソルを持ってきたい場合には使えません。

### Ctrl + Alt + SHIFT  カーソル左右 

スペースやハイフンなど何らかの区切り文字までカーソルを移動します。 __カーソル1つだけの時には「素早くカーソル移動できる便利機能」くらいの位置付けだったと思いますが、 マルチカーソルではこのキーワード単位のカーソル移動が必須テクニックになってきます。__ 思った通りの区切り単位で移動してくれるとは限らないのでちょっとクセがあります。

![option_cursor.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/f9bb747e-45ad-55f6-7c91-46f813eefdd5.gif)

### Home

行頭にカーソルを移動します。前項で紹介したCtrl + カーソル左右ではキーワード単位での移動になってしまうので、カーソルがみんな揃って行頭まで移動してくれないことがよくあります。なのでHomeキーを使います。

![command_cursor.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/fa52a9a2-cf28-3380-e6e3-9d023c3c4c06.gif)


### End 

前項のワザの逆で、行末にカーソルを移動します。

![cursor_right.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/40ca497e-bda9-6825-b797-f3a9a580668b.gif)

※一番下の`updatedUser`の選択に失敗してて超カッコ悪い・・・のですがよくやってしまうのであえてそのままで。。。

## マルチカーソルを活用した編集のポイント

マルチカーソルを狙った場所に置くことができたら、それを生かして一気に編集します。
もちろん普通に文字入力するだけでも便利ですが、他にも強力なワザがあります。

### 普通に文字入力する

一括で接頭辞・接尾辞をつけたり、同じキーワードのスペルを一括で編集したりと幅広く使えます。

![edit.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/6e2a2a61-941f-69e0-6aad-a26e2929e11b.gif)

### 範囲選択して、当該箇所を上書きする

簡易的な置換として使えます。(個人的には普通の置換よりこっちの方がよく使います)

![replace.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/bce0e43b-9b41-da0d-8f95-858ea80adbef.gif)


### 範囲選択して、コピペする

__マルチカーソルの醍醐味！！__ JSONからキーだけ抜き出して別のコードで使用するみたいなことが可能になります。

![json_key.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/1a024aae-384c-1588-c619-b060d74d1b28.gif)

### マルチカーソルを維持したまま貼り付ける

前項のワザを使ってコピーした内容を、マルチカーソルを維持したまま貼り付けることが可能です。

![multi_paste.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/c21b9f21-33b8-83b6-19fb-df93e271d459.gif)


### 拡張機能を使って編集する: ケース変換

change-case みたいな拡張機能を使って、キャメルケースやスネークケースなどのケース変換ができます。以前まで私は「この拡張機能なんに使うんだ・・・」とバカにしていましたがマルチカーソルと組み合わせるとかなり便利です。 __正直ドヤ顔できるぞ！__

![json2java.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/5294f1d8-863f-373a-2065-b6c85b0683fd.gif)

### ( 拡張機能を使って編集する: 数字挿入

[Insert Numbers](https://github.com/Inori/vscode-InsertNumbers/) で数字の一括挿入なんてどうでしょう。
こういった拡張機能の存在自体、マルチカーソルの活用を前提としている節がありますが。

![ss202102180957.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/156941/e8aef3c3-f561-7e30-5e42-411ec0c5f79b.gif)


---

基本的なマルチカーソルのワザは以上です。あとは組み合わせで何とかなる領域だと思います。それでは快適なVSCodeライフを！

# 環境

Visual Studio 2019

# その他の出展

* [VS Code の便利なショートカットキー @12345さん](https://qiita.com/12345/items/64f4372fbca041e949d0)
