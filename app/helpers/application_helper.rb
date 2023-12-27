module ApplicationHelper
  # name: リンクの表示名
  # path: リンク先のパス
  def header_link_item(name,path)
    # bootstrapのデザインに合わせるため必ずつけるクラス
    class_name = 'nav-item'
    # activeの前には必ずスペースが必要(class="nav-itev active"となる)
    # current_page?メソッドで表示するパスと引数のパスが同一かを判定しするヘルパー
    class_name << ' active' if current_page?(path)

    # liタグを作成、ブロック内に記載したHTMLはタグの中に展開される
    # 今回の場合はliタグの中にaタグが埋め込まれて呼び出し先に返される
    content_tag :li, class: class_name do 
      link_to name, path, class: 'nav-link'
    end
  end
end
