Jkscience::Application.routes.draw do
  #devise_for :users , :controllers => {:passwords => "passwords"}
  devise_for :users do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  resources :passwords
  resources :users
  resources :profile
  resources :homes
  resources :roles
  resources :teachers
  resources :students
  resources :admins
  resources :reports
  resources :subjects do
    resources :jktests do
      resources :testquestions
    end
    resources :chapters do
      resources :topics do 
        resources :questions
        resources :forums do
          resources :posts
        end
      end
    end
  end
  resources :batchs do
    resources :batchstudents
    resources :batchtests do
      resources :testattempts
      resources :solvedtests
    end
  end

  match '/batchs/:batch_id/batchstudents/add_batch_student', :controller=>'batchstudents', :action => 'add_batch_student', :via => :post
  match '/batchs/:batch_id/batchtests/add_batch_test', :controller=>'batchtests', :action => 'add_batch_test', :via => :post
  match '/jktest/select_subject', :controller=>'jktests', :action => 'select_subject', :via => :get
  match '/question/filter_question', :controller=>'questions', :action => 'filter_question', :via => :get
  match '/subject/:subject_id/questions', :controller=>'questions', :action => 'subject_questions', :via => :get
  match '/subject/:subject_id/chapter/:chapter_id/questions', :controller=>'questions', :action => 'chapter_questions', :via => :get
  match '/subject/:subject_id/chapter/:chapter_id/topic/:topic_id/questions', :controller=>'questions', :action => 'topic_questions', :via => :get
  match '/subject/:subject_id/jktest/:jktest_id/add_test_questions', :controller => 'testquestions', :action => 'add_test_questions', :via => :post

  match '/subject/filter_forum', :controller=>'forums', :action => 'filter_forum', :via => :get
  match '/subject/:subject_id/forums', :controller=>'forums', :action => 'subject_forums', :via => :get
  match '/subject/:subject_id/chapter/:chapter_id/forums', :controller=>'forums', :action => 'chapter_forums', :via => :get
  match '/subject/:subject_id/chapter/:chapter_id/topic/:topic_id/forums', :controller=>'forums', :action => 'topic_forums', :via => :get
  match '/todays_test', :controller=>'profile', :action => 'todays_test', :via => :get
  match '/batch_test/:batchtest_id/student/:student_id/jktest/:jktest_id', :controller => 'start_test', :action => 'show', :via => :get
  match '/batch_test/:batchtest_id/student/:student_id/jktest/:jktest_id/result', :controller => 'start_test', :action => 'result', :via => :post
  match '/show_profile' , :controller => 'profile', :action => 'show_profile'
  match '/change_password' , :controller => 'profile', :action => 'change_password'
  match '/forum/:topic_id/show', :controller => 'start_test', :action => 'question_forum', :via => :get
  match '/forum/:forum_id/post/:topic_id/new', :controller => 'start_test', :action => 'question_forum_new_post', :via => :post
  match '/notification', :controller => 'home', :action => 'notification', :via => :get
  match '/results', :controller => 'home', :action => 'result', :via => :get
  match '/why_to_join_us', :controller => 'home', :action => 'join_us', :via => :get
  match '/about', :controller => 'home', :action => 'about', :via => :get
  
# The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
