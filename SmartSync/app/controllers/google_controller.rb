# class GoogleController < ApplicationController

#   def oauth
#     redirect_to "https://accounts.google.com/o/oauth2/auth?client_id=#{ENV['CLIENT_ID']}&response_type=code&scope=openid%20email&redirect_uri=http://localhost:3000/oauth/redirect&state=#{ENV['STATE']}"
#   end

#   def token

#     console_alert({  title: "GET 'google/oauth/redirect'",
#       message: "Params",
#       parameters: params })

#     if params[:state] != ENV['STATE']
#       console_alert({ title: "Oauth 'STATE' Validation Alert",
#         message: "Oauth 'STATE' Validation Does Not Match\nPotential Hacker Warning" })
#     else
#       console_alert({ title: "Oauth 'STATE' Validation Passed" })
#     end

#     options = { code: params[:code],
#       redirect_uri: "http://localhost:3000/oauth/redirect",
#       client_id: ENV['CLIENT_ID'],
#       client_secret: ENV['CLIENT_SECRET'],
#       grant_type: "authorization_code" }

#       console_alert({ title: "Info Sent to Google for Token",
#        parameters: options })

#       token_response = HTTParty.post("https://www.googleapis.com/oauth2/v3/token", body: options)

#       token = token_response.parsed_response["access_token"]
#       expires = token_response.parsed_response["expires_in"]
#       uid = token_response.parsed_response["id_token"]

#       user_info_response = HTTParty.get("https://www.googleapis.com/oauth2/v3/userinfo", headers: { "Authorization" => "Bearer #{token}" })

#       console_alert({ title: "Google Oauth User Info Response",
#        parameters: user_info_response.parsed_response })

#       user = oauth_update_user(user_info_response.parsed_response, token, expires, uid)

#       console_alert({ title: "User Successfully Logged In",
#         parameters: { user_id: user.id } })

#       oauth_login(user, token)

#       if user.uid == user.password
#         redirect_to 'oauth_update_profile_path'
#       else
#         redirect "/user/#{user.id}"
#       end

#     end

#     def profile_edit
#       @user = User.find(session[:user_id])
#     end

#     def profile_update
#       @user = User.find(session[:user_id])

#       if @user.update(oauth_params)
#         redirect_to @user
#       else
#         render 'edit'
#       end
#     end

#     private

#     def oauth_params
#       params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation)
#     end

#     def oauth_update_user(args, token, expires, uid)

#       console_alert({  title: "Update User From Oauth'",
#        message: "Parameters Received From Google",
#        parameters: args })

#       user = User.find_by(email: args.fetch("email")) || User.new(email: args.fetch("email"))
#       user.name = args.fetch("name")
#       user.first_name = args.fetch("given_name")
#       user.last_name = args.fetch("family_name")
#       user.picture = args.fetch("picture")
#       user.token = token
#       user.password = uid
#       user.expires = expires
#       user.uid = uid

#       user.save
#       return user
#     end

#     def oauth_login(user, token)
#       session[:user_id] = user.id
#       session[:access_token] = token
#       @current_user = user
#     end

#     def oauth_logged_in?
#       !!session[:user_id]
#     end


#   end
