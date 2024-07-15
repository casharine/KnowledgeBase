# GOFデザインパターン：FactoryMethodパターン編

## 

// 入金機関
Kinyuukikan
// 得意先コード(下二桁トリム）
TokuisakiCodeTrimmed
// 得意先名（フル）
TokuisakiMeiYomiSeishiki
// 金額（税抜）
Shoukei
// 消費税
ShouhiZei
// 合計金額（税込）
Goukei

### GOFとは


### 本APIの工夫点
インスタンス化のロジックを一元化させ、再利用性、拡張性、保守性をのばす事を目的にGOFデザインパターンのBuilderパターン、Factoryパターンに挑戦しました。

### 当時の課題
C# .netCore WebAPIを初採用し、今後C#APIにコアロジックは集約していきたいので、APIの基部構築を任されました。ただ、サイト毎のController側のメソッドと購入クラスはまとめないでほしいと制限がありましたが、ECサイトがプラットフォームに追加される度Controllerは肥大化し無駄な改修・テストコストがかかりました。そこで続く類似のプラットフォーム構築プロジェクト時に






