Rails.application.routes.draw do
  resources :folders
  resources :documents
  get 'home/index'
  devise_for :users
  root :to => "home#index"

  #this route is for file downloads 
  match "documents/get/:id" => "documents#get", :via => [:get], :as => "download"

  match "browse/:folder_id" => "home#browse", :via => [:get], :as => "browse"
  #for creating folders insiide another folder 
  match "browse/:folder_id/new_folder" => "folders#new", :via => [:get], :as => "new_sub_folder"
  #for uploading files to folders 
  match "browse/:folder_id/new_file" => "documents#new", :via => [:get], :as => "new_sub_file"

  #for renaming a folder 
  match "browse/:folder_id/rename" => "folders#edit", :via => [:get], :as => "rename_folder"

end
