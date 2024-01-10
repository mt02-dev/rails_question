require "rails_helper"

RSpec.describe  UsersController, type: :controller do

  describe 'GET #new' do
   # get メソッドでアクセスすることを擬似的にテスト前に実行
   # responseという変数に実行結果が格納される
   before { get :new }
   
   it 'レスポンスコードが200であること' do
    # have_http_status はmatcher
    expect(response).to have_http_status(:ok)
   end

   it 'newテンプレートをレンダリングすること' do
    # rails-controller-testingをインストールすることでrender_templeteを利用できる
    # `render_template`を利用すると指定したテンプレートがレンダリングされているかテストされる
    expect(response).to render_template :new
   end

   # viewに渡されるべきオブジェクトが正しいかどうかのテスト
   # be_a_new でUserクラスのオブジェクトがセットされていることを確
   it '新しいuserオブジェクトがビューに渡されること' do
    expect(assigns(:user)).to be_a_new User
   end
  end

  describe 'POST #create' do
    before do
      @referer = 'http://localhost/users/new'
      @request.env['HTTP_REFERER'] = @referer
    end

    context 'ユーザ情報が正しくわたってきた場合' do
      let(:params) do
        {
          user: {
            name: 'user',
            password: 'password',
            password_confirmation: 'password' 
          }
        }
      end

      it 'ユーザが1人増えていること' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end

      it '登録したユーザのマイページにリダイレクトすること' do
        expect(post :create, params: params).to redirect_to(mypage_path)
      end
    end

    context 'ユーザ情報が正しく渡っていない場合' do
      before do
          post(:create, params: {
            user: {
              name: 'ユーザ1',
              password: 'password',
              password_confirmation: 'invalid_pass'
            }
          })
      end

      it 'リファラーにリダイレクトされること' do
        expect(response).to redirect_to(@referer)
      end

      it 'ユーザ名のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザ名は小文字英数字で入力してください'
      end

      it 'パスワード確認のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'パスワード(確認)とパスワードの入力が一致しません'
      end
    end

  end

end