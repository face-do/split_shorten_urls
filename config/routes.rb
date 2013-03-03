ShortenUrl::Application.routes.draw do

  scope "/g" do  
    resources :urls, :except => :edit
    get "new_link_form" => 'urls#new_link_from'
  end

  scope "/" do
  	get ":id" => 'urls#redirect'
  end
  root to: 'urls#index'
end
