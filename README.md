# nvim-cheats

Omarchy (Hyprland) 環境向けの、軽量で高速な Neovim チートシートランチャーです。
「あの操作、キーバインドなんだっけ？」を瞬時に解決します。


https://github.com/user-attachments/assets/771630a0-5186-4c3e-bd7b-9bb087187e77

## 特徴

*   **高速起動**: `Super + V` (デフォルト) で瞬時にフローティングウィンドウとして起動。
*   **曖昧検索**: `fzf` を使用しており、コマンド名、説明、タグから柔軟に検索可能。
*   **タグ検索**: `[Window]` や `[Movement]` などのタグでフィルタリングでき、`<C-w>` などのキー自体の意味も検索可能。
*   **多言語対応**: システムのロケール (`LANG`) に応じて、自動的に日本語/英語を切り替えます。
*   **Omarchy 親和性**: Omarchy の設計思想に合わせた設定ファイル構成。

## インストール

1.  リポジトリをクローンします。
    ```bash
    git clone https://github.com/yourusername/nvim-cheats.git
    cd nvim-cheats
    ```

2.  インストーラを実行します。
    ```bash
    chmod +x install.sh
    ./install.sh
    ```

3.  Hyprland の設定ファイル (`~/.config/hypr/hyprland.conf` または `bindings.conf`) に以下を追記して読み込みます。
    ```ini
    source = ~/.config/hypr/nvim-cheats.conf
    ```

4.  設定を反映させます。
    ```bash
    hyprctl reload
    ```

## 使い方

*   **起動**: `Super + I` (デフォルト)
*   **検索**:
    *   `save` -> 保存関連のコマンドを検索
    *   `window` -> ウィンドウ操作関連 (`[Window]` タグ) を検索
    *   `leader` -> Leader キー関連を検索
*   **終了**: `ESC` またはウィンドウを閉じる

## カスタマイズ

### キーバインドの変更
`~/.config/hypr/nvim-cheats.conf` を編集してください。

```ini
# 例: Super + H で開くように変更
bind = SUPER, H, exec, ghostty --title=nvim-cheats -e ~/.config/hypr/scripts/nvim-cheats.sh
```

### コマンドの追加・編集
データファイルは以下の場所にあります。これらを直接編集することで、自分だけのチートシートを作成できます。

*   **日本語**: `~/.config/hypr/scripts/data/ja`
*   **英語**: `~/.config/hypr/scripts/data/en`

形式:
```text
コマンド    [タグ][タグ] 説明
```

## ライセンス

MIT
