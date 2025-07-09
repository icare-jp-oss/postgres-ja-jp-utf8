# postgres-ja-jp-utf8

`postgres` with language ja_jp_utf8

## Docker Image

[docker hub](https://hub.docker.com/r/icarejposs/postgres-ja-jp-utf8)でイメージをホストしています。

## docker hubでイメージをホストする仕組み

- Automated buildsの機能でgit pushに反応してホストされる
- PostgreSQLのバージョンアップ時などは下記対応を行う
    - DockerfileのFROMを更新
    - PRを作成
    - docker hub上でイメージがビルドされることを確認
    - 該当のブランチに対してタグをpush
        - 例

    ```
    git tag -a **.**(version) -m "image with Postgres version **.**"
    git push origin --tags <branche-name>
    ```
    - docker hub上でイメージがビルドされることを確認 
