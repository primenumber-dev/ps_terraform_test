## これは何か？
顧客向けに提供するデータ基盤の構築リードタイムを最小化しつつ要件の柔軟性に耐えうるためのTerraformプロジェクトです。
プロジェクトごとに該当のディレクトリを作成し、そこでコード開発を行います。

## ディレクトリ構造
- modules
    - jobs
        - データエンジニアリングライフサイクルの1工程を担うタスクを定義します
        - データパイプラインにおいて一番粒度の低い概念です。
        - 上位のpipelinesやroot moduleから呼び出します
    - pipelines
        - データエンジニアリングライフサイクルの複数工程を担うタスクを定義します
        - 複数のjobsから構成されます
        - 上位のroot moduleから呼び出します

- example.tf
    - 各プロジェクトでIaC開発を行うためのサンプルを定義します

- projects
    - プロジェクトごとに基盤構築を行うIaCリソースを記述していきます
    - main.tf
        - プロジェクトにおいて必要なパイプラインリソースを記述します
        - 既にpipelinesモジュールとして抽象化されたパターンの利用であればpipelinesを呼び出してvariableで肉付けします
        - pipelinesモジュールに用意されていないカスタマイズ性の高いリソースを使用したい場合はjobsの呼び出し、または直接リソースを定義します